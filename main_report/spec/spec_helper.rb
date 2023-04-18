# spec_helper.rb
require_relative "../black_jack_2"
require 'rspec'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end