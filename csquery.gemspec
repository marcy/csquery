# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csquery/version'

Gem::Specification.new do |spec|
  spec.name          = "csquery"
  spec.version       = Csquery::VERSION
  spec.authors       = ["marcy"]
  spec.email         = ["masashi.oyamada@gmail.com"]
  spec.license       = "MIT"

  spec.summary       = %q{A simple query builder for Amazon Cloudsearch Structured query parser.}
  spec.description   = %q{A simple query builder for Amazon Cloudsearch Structured query parser.}
  spec.homepage      = "https://github.com/marcy/csquery"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata = {
    "homepage_uri"    => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri"   => "https://github.com/marcy/csquery/blob/master/CHANGELOG.md",
    "bug_tracker_uri" => "https://github.com/marcy/csquery/issues"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
