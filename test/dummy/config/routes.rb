Rails.application.routes.draw do
  mount Spinnaker::Sidekiq::Engine => "/spinnaker/sidekiq"
end
