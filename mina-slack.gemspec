# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/slack/version'

Gem::Specification.new do |spec|
  spec.name        = 'mina-slack'
  spec.version     = Mina::Slack::VERSION
  spec.authors     = ['TAKAyuki_atkwsk', 'Marcos G. Zimmermann']
  spec.email       = ['takagi.takayuki.yuuki@gmail.com', 'mgzmaster@gmail.com']
  spec.description = 'Slack web hook from mina'
  spec.summary     = 'Slack web hook from mina'
  spec.homepage    = 'https://github.com/TAKAyukiatkwsk/mina-slack'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'mina', '>= 1.0'
end
