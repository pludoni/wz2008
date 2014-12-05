$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wz2008/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wz2008"
  s.version     = Wz2008::VERSION
  s.authors     = ["Stefan Wienert"]
  s.email       = ["stefan.wienert@pludoni.de"]
  s.homepage    = "https://github.com/pludoni/wz2008"
  s.summary     = "WZ2008 industrial classification codes as ActiveRecord tree "
  s.description = "WZ2008 industrial classification codes as ActiveRecord tree "
  s.license     = "MIT"

  s.files = Dir["{app,config,data,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1"
  s.add_dependency "ancestry"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rails-dummy"
  s.add_development_dependency "pry"
end
