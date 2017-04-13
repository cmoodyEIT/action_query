# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_query/version'

Gem::Specification.new do |spec|
  spec.name          = "action_query"
  spec.version       = ActionQuery::VERSION
  spec.authors       = ["Chris Moody"]
  spec.email         = ["cmoody.eit@gmail.com"]

  spec.summary       = %q{Jquery lifecycle for rails object.}
  spec.description   = %q{Use this gem to provide an easy JQuery based wrapper for your routes.}
  spec.homepage      = "https://github.com/cmoodyEIT/action_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     'jquery-rails'
  spec.add_runtime_dependency     'coffee-rails'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
