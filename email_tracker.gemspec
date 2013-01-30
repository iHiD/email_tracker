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
  s.summary     = "A plugin for Rails apps that tracks email."
  s.description = "A plugin for Rails apps that tracks email."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "webrat"
  s.add_development_dependency "method_profiler"
end
