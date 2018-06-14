# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fcoin/version'

Gem::Specification.new do |spec|
  spec.name          = "fcoin"
  spec.version       = Fcoin::VERSION
  spec.authors       = ["EricZhu"]
  spec.email         = ["zhuyuchao.personal@gmail.com"]
  spec.summary       = %q{Ruby wrapper for huobi api}
  spec.description   = %q{Ruby wrapper for huobi api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.15"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
