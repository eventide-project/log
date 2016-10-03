# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'log'
  s.version = '0.0.0.0'
  s.summary = 'Logging to STDERR with levels, tagging, and coloring'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/log'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'initializer'
  s.add_runtime_dependency 'dependency'
  s.add_runtime_dependency 'telemetry'
  s.add_runtime_dependency 'clock'

  s.add_runtime_dependency 'rainbow'

  s.add_development_dependency 'test_bench'
end
