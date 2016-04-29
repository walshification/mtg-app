# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tolarian_registry/version'

Gem::Specification.new do |spec|
  spec.name          = "tolarian_registry"
  spec.version       = TolarianRegistry::VERSION
  spec.authors       = ["walshification"]
  spec.email         = ["walshification@gmail.com"]
  spec.summary       = %q{A one-stop api wrapper for all Magic: the Gathering information.}
  spec.description   = %q{A one-stop api wrapper for all Magic: the Gathering information.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "unirest"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
