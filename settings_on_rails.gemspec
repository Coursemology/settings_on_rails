# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'settings_on_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'settings_on_rails'
  spec.version       = SettingsOnRails::VERSION
  spec.authors       = ['Bivan Alzacky Harmanto']
  spec.email         = ['bivan.alzacky@gmail.com']

  spec.summary       = %q{Model specific Hash Preferences/Settings for Rails.}
  spec.description   = %q{Ruby gem help to handle key/value settings(preferences) for ActiveRecord model. Settings are stored in hash, supports nested/multiple keys and default values.}
  spec.homepage      = 'https://github.com/bivanalhar/settings_on_rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 3'
  spec.add_dependency 'rails', '>= 6'

  spec.add_development_dependency 'sqlite3', '~> 1.7'
  spec.add_development_dependency 'bundler', '>= 1.6'
  spec.add_development_dependency "appraisal", "~> 2.1"
  spec.add_development_dependency 'rake'
end
