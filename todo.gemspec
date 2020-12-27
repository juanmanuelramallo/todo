# frozen_string_literal: true

require_relative 'lib/version'

Gem::Specification.new do |spec|
  spec.name                         = 'todo_cli_app'
  spec.version                      = ToDo::VERSION
  spec.licenses                     = ['MIT']
  spec.summary                      = 'A ruby cli-only to-do app'
  spec.description                  = 'A to-do app, the ruby cli-only edition to-do app [insert registered mark '\
                                      'logo here].'
  spec.authors                      = ['Juan Manuel Ramallo']
  spec.email                        = 'juanmanuelramallo@hey.com'
  spec.files                        = Dir['README.md', 'LICENSE.txt', 'lib/**/*']
  spec.homepage                     = 'https://github.com/juanmanuelramallo/todo'
  spec.metadata['homepage_uri']     = spec.homepage
  spec.metadata['source_code_uri']  = spec.homepage
  spec.bindir                       = 'exe'
  spec.executables                  = ['todo']
  spec.required_ruby_version        = Gem::Requirement.new('>= 2.5.0')
end
