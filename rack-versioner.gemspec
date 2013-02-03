# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack-versioner/version'

Gem::Specification.new do |gem|
  gem.name          = "rack-versioner"
  gem.version       = Rack::Versioner::VERSION
  gem.authors       = ["Rajiv"]
  gem.email         = ["rajiv@liftprojects.com"]
  gem.description   = %q{Rack Middleware to extract versions from for API calls from path, header, and query.}
  gem.summary       = %q{Rack Middleware to extract versions from for API calls from path, header, and query.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
