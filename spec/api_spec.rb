# frozen_string_literal: true
require_relative 'spec_helper'

describe 'API basics' do
  before do
    VCR.insert_cassette(cassette_name(__FILE__, name), record: :new_episodes)
  end

  after do
    VCR.eject_cassette
  end

  it 'should find configuration information' do
    app.config.access_token.length.must_be :>, 0
  end

  it 'should successfully find the root route' do
    get '/'
    last_response.body.must_include 'TweetSearch'
    last_response.status.must_equal 200
  end
end
