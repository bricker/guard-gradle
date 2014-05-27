# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/gradle/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-gradle'
  spec.version       = Guard::GradleVersion::VERSION
  spec.authors       = ['Bryan Ricker']
  spec.email         = ['bricker88@gmail.com']
  spec.description   = %q{Guard plugin for Gradle builds}
  spec.summary       = %q{Build your Java projects as you work.}
  spec.homepage      = 'https://github.com/bricker/guard-gradle'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard', '~> 2.2.5'
  spec.add_development_dependency 'test-unit', '>= 2.5.5'
  spec.add_development_dependency 'mocha', '>= 1.0.0'
end
