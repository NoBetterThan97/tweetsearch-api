# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Tweet Routes' do
  before do
    VCR.insert_cassette(cassette_name(__FILE__, name), record: :new_episodes)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Find Tweet by tag' do
    it 'HAPPY: should find a tweet which have hashtags' do
      get "/#{app::API_VER}/tweets/#{HAPPY_TWEET_TAG}"

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      tweet_data = JSON.parse(last_response.body)
      tweet_data.length.must_be :>, 0
    end

    it 'SAD: should find a tweet which have not hash' do
      get "/#{app::API_VER}/tweets/#{SAD_TWEET_TAG}"

      last_response.status.must_equal 404
    end
  end
end
