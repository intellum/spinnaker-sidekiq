require "spinnaker/sidekiq/engine"

module Spinnaker
  module Sidekiq
    class MissingApiToken < StandardError
      def initialize(msg = "Set SPINNAKER_SIDEKIQ_API_TOKEN environment variable or Spinnaker::Sidekiq.api_token")
        super
      end
    end

    class << self
      attr_writer :api_token, :shutdown_signal_ttl, :terminate_callback

      def api_token
        @api_token ||= ENV.fetch("SPINNAKER_SIDEKIQ_API_TOKEN") { raise MissingApiToken }
      end

      def shutdown_signal_ttl
        @shutdown_signal_ttl ||= ENV.fetch("SPINNAKER_SIDEKIQ_SHUTDOWN_SIGNAL_TTL", 30).to_i
      end

      def terminate_callback
        @terminate_callback || raise("terminate_callback not set")
      end
    end
  end
end
