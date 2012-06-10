$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "email_tracker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "email_tracker"
  s.version     = EmailTracker::VERSION
  s.authors     = ["Jeremy Walker"]
  s.email       = ["jez.walker@gmail.com"]
  s.homepage    = "http://www.ihid.co.uk/email_tracker"
  s.summary     = "A plugin for Rails apps that track email."
  s.description = "A plugin for Rails apps that track email."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
end
