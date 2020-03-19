module Spinnaker
  module Sidekiq
    class Engine < ::Rails::Engine
      isolate_namespace Spinnaker::Sidekiq
    end
  end
end
