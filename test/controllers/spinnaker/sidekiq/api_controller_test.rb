require "test_helper"

module Spinnaker
  module Sidekiq
    class ApiControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        ENV["SPINNAKER_API_AUTHENTICATION_TOKEN"] = "secret"
        @credentials = ActionController::HttpAuthentication::Token.encode_credentials("secret")
      end

      test "status without authentication fails" do
        get "/spinnaker/sidekiq/status"

        assert_response 401
      end

      test "status without started_at param returns all processes" do
        processes = [
          {"started_at" => Time.now, "busy" => 1}
        ]

        ::Sidekiq::ProcessSet.stub :new, processes do
          get "/spinnaker/sidekiq/status", headers: {"HTTP_AUTHORIZATION" => @credentials}
        end

        status = JSON.parse(response.body)["status"]
        assert_equal "busy", status
      end

      test "status with started_at after process started count process" do
        processes = [
          {"started_at" => 1.day.ago.to_i, "busy" => 1}
        ]

        ::Sidekiq::ProcessSet.stub :new, processes do
          get "/spinnaker/sidekiq/status",
            params: {started_at: Time.now.to_i},
            headers: {"HTTP_AUTHORIZATION" => @credentials}
        end

        status = JSON.parse(response.body)["status"]
        assert_equal "busy", status
      end

      test "status with started_at before process started does not count process" do
        processes = [
          {"started_at" => 1.day.from_now.to_i, "busy" => 1}
        ]

        ::Sidekiq::ProcessSet.stub :new, processes do
          get "/spinnaker/sidekiq/status",
            params: {started_at: Time.now.to_i},
            headers: {"HTTP_AUTHORIZATION" => @credentials}
        end

        status = JSON.parse(response.body)["status"]
        assert_equal "quiet", status
      end

      test "quiet_all without authentication fails" do
        post "/spinnaker/sidekiq/quiet_all"
        assert_response 401
      end

      test "quiet_all quiets processes" do
        process = MiniTest::Mock.new
        process.expect(:quiet!, nil)

        ::Sidekiq::ProcessSet.stub :new, [process] do
          post "/spinnaker/sidekiq/quiet_all",
            headers: {"HTTP_AUTHORIZATION" => @credentials}
        end
      end
    end
  end
end
