$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_record'
require 'settings_on_rails'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.order = :random
end

if ActiveRecord.version > Gem::Version.new('6.2')
  ActiveRecord.use_yaml_unsafe_load = true
else
  ActiveRecord::Base.use_yaml_unsafe_load = true
end
