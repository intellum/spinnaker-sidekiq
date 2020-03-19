require_dependency "spinnaker/sidekiq/application_controller"
require "sidekiq/api"

module Spinnaker
  module Sidekiq
    class ApiController < ApplicationController
      before_action :authenticate

      # This will be used by a webhook stage to quiet all workers during deployment
      def quiet_all
        ps = ::Sidekiq::ProcessSet.new
        ps.each(&:quiet!)
        render plain: '', location: url_for(action: 'status', started_at: Time.now.to_i)
      end

      # This will be used to poll the status of the sidekiq workers.
      def status
        ps = ::Sidekiq::ProcessSet.new

        processes = ps.reject do |process|
          params[:started_at] && process['started_at'] > DateTime.strptime(params[:started_at],'%s').to_i
        end

        busy_jobs = processes.sum { |process| process['busy'] }

        status = busy_jobs == 0 ? 'quiet' : 'busy'

        render json: { status: status, progress: "Pending jobs: #{busy_jobs}" }
      end

      private

      def authenticate
        authenticate_or_request_with_http_token do |token, _options|
          token_digest = ::Digest::SHA256.hexdigest(token)
          api_auth_token_digest = ::Digest::SHA256.hexdigest(api_authentication_token)

          ActiveSupport::SecurityUtils.secure_compare(token_digest, api_auth_token_digest)
        end
      end

      def api_authentication_token
        ENV.fetch('SPINNAKER_API_AUTHENTICATION_TOKEN') { raise 'Missing API token!' }
      end
    end
  end
end
