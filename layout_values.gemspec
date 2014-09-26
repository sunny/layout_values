$:.push File.expand_path("../lib", __FILE__)

require "layout_values/version"

Gem::Specification.new do |s|
  s.name        = "layout_values"
  s.version     = LayoutValues::VERSION
  s.authors     = ["Sunny Ripert"]
  s.email       = ["sunny@sunfox.org"]
  s.homepage    = "http://github.com/sunny"
  s.summary     = "Add helpers to indicate page titles and meta description."
  s.description = ""

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.3"

  s.add_development_dependency "rspec"
end
