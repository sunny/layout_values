$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "layout_values/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "layout_values"
  s.version     = LayoutValues::VERSION
  s.authors     = ["Sunny Ripert"]
  s.email       = ["sunny@sunfox.org"]
  s.homepage    = "http://github.com/sunny"
  s.summary     = "Add helpers to indicate page titles and meta description."
  s.description = ""

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.1"

  s.add_development_dependency "rspec"
end
