# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/slack/version'

Gem::Specification.new do |spec|
  spec.name          = "mina-slack"
  spec.version       = Mina::Slack::VERSION
  spec.authors       = ["TAKAyuki_atkwsk"]
  spec.email         = ["takagi.takayuki.yuuki@gmail.com"]
  spec.description   = %q{Slack web hook from mina}
  spec.summary       = %q{Slack web hook from mina}
  spec.homepage      = "https://github.com/TAKAyukiatkwsk/mina-slack"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'rest-client', '~> 1.6.7'
  spec.add_runtime_dependency 'mina', '~> 0.3.0'
end
