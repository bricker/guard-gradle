# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/gradle/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-gradle'
  spec.version       = Guard::GradleVersion::VERSION
  spec.authors       = ['Bryan Ricker', 'Andrew Glover']
  spec.email         = ['bricker88@gmail.com', 'ajglover@gmail.com']
  spec.description   = %q{Continuous Testing Guard plugin for Gradle}
  spec.summary       = %q{Build & test your Java projects continuously as you work.}
  spec.homepage      = 'https://github.com/bricker/guard-gradle'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard', '~> 2.6.1'
  spec.add_development_dependency 'test-unit', '>= 2.5.5'
  spec.add_development_dependency 'mocha', '>= 1.0.0'
end
