require "test_helper"

class Spinnaker::Sidekiq::Test < ActiveSupport::TestCase
  teardown do
    Spinnaker::Sidekiq.api_token = nil
    ENV.delete("SPINNAKER_SIDEKIQ_API_TOKEN")
  end

  test "api_token must be set" do
    assert_raises Spinnaker::Sidekiq::MissingApiToken do
      Spinnaker::Sidekiq.api_token
    end
  end

  test "api_token can be set with environment variable" do
    ENV["SPINNAKER_SIDEKIQ_API_TOKEN"] = "env-var"
    assert_equal "env-var", Spinnaker::Sidekiq.api_token
  end

  test "api_token can be set on the module" do
    Spinnaker::Sidekiq.api_token = "module"
    assert_equal "module", Spinnaker::Sidekiq.api_token
  end
end
