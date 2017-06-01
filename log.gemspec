# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-log'
  s.version = '0.4.3.5'
  s.summary = 'Logging to STD IO with levels, tagging, and coloring'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/log'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-initializer'
  s.add_runtime_dependency 'evt-dependency'
  s.add_runtime_dependency 'evt-telemetry'
  s.add_runtime_dependency 'evt-clock'

  s.add_runtime_dependency 'terminal_colors'

  s.add_development_dependency 'test_bench'
end
