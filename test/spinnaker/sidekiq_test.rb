require "test_helper"

class Spinnaker::SidekiqTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Spinnaker::Sidekiq::VERSION
  end
end
