# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coverage_peek/version'

Gem::Specification.new do |spec|
  spec.name          = "coverage_peek"
  spec.version       = CoveragePeek::VERSION
  spec.authors       = ["Nelson Elhage"]
  spec.email         = ["nelhage@nelhage.com"]

  spec.summary       = %q{Compatibility implementation of Coverage.peek_result}
  spec.homepage      = "https://github.com/nelhage/coverage_peek"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/coverage_peek/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest", "~> 5.0"
end
