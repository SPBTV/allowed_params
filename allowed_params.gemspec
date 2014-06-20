$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "allowed_params/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "allowed_params"
  s.version     = AllowedParams::VERSION
  s.authors     = ["Tema Bolshakov", "Dmitry Rybakov"]
  s.email       = ["abolshakov@spbtv.com", "drybakov@spbtv.com"]
  s.homepage    = "https://github.com/SPBTV/allowed_params"
  s.summary     = "Filter params on rails controllers"
  s.description = "Allow to filter and validate params on rails controllers"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency 'rails', '~> 4.0'
  s.add_development_dependency "sqlite3", '~> 0'
  s.add_development_dependency "rspec-rails", "~> 3"
end
