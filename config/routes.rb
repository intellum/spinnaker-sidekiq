Spinnaker::Sidekiq::Engine.routes.draw do
  post "/quiet_all", to: "api#quiet_all"
  get "/status", to: "api#status"

  post "/terminate_all", to: "api#terminate_all"
end
