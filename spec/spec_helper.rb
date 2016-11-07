# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/rg'
require 'minitest/autorun'
require 'rack/test'
require 'vcr'
require 'webmock'

require_relative '../app'

include Rack::Test::Methods

def app
  TweetSearchAPI
end

CASSETTES_FOLDER = 'spec/support/cassettes'
SAD_TWEET_TAG = 'aeneannectortorfelisDuisegestasantesedduiposuereplacerat'
HAPPY_TWEET_TAG = 'food'

VCR.configure do |config|
  config.cassette_library_dir = CASSETTES_FOLDER
  config.hook_into :webmock

  config.filter_sensitive_data('<ACCESS_TOKEN>') { ENV['access_token'] }
end

def cassette_name(path_to_spec, description)
  spec_filename = File.basename(path_to_spec, '.*')
  spec_description = description.gsub(/^test_[0-9]+_/, '')

  "#{spec_filename} #{spec_description}"
end
