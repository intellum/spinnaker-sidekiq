$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spinnaker/sidekiq/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "spinnaker-sidekiq"
  s.version = Spinnaker::Sidekiq::VERSION
  s.authors = ["Jorge Dias"]
  s.email = ["jdias@intellum.com"]
  s.homepage = "https://github.com/intellum/spinnaker-sidekiq"
  s.summary = "Spinnaker Sidekiq integration"
  s.description = "API to implement a webhook stage for spinnaker to stop sidekiq workers gracefully"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0"
  s.add_dependency "sidekiq", ">= 4.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "standard"
  s.add_development_dependency "gem-release"
  s.add_development_dependency "appraisal"
end
