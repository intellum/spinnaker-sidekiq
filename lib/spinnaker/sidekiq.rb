require "spinnaker/sidekiq/engine"

module Spinnaker
  module Sidekiq
    class MissingApiToken < StandardError
      def initialize(msg = "Set SPINNAKER_SIDEKIQ_API_TOKEN environment variable or Spinnaker::Sidekiq.api_token")
        super
      end
    end

    class << self
      attr_writer :api_token

      def api_token
        @api_token ||= ENV.fetch("SPINNAKER_SIDEKIQ_API_TOKEN") { raise MissingApiToken }
      end
    end
  end
end
