# frozen_string_literal: true
require 'sinatra'
require 'econfig'
require 'tweetsearch'

# GroupAPI web service
class TweetSearchAPI < Sinatra::Base
  extend Econfig::Shortcut

  Econfig.env = settings.environment.to_s
  Econfig.root = settings.root

  ENV['access_token'] = config.access_token

  API_VER = 'api/v0.1'.freeze

  get '/?' do
    "TweetSearchAPI latest version endpoints are at: /#{API_VER}/"
  end

  get "/#{API_VER}/tweetsearch/:tags/?" do
    tags = params[:tags]
    begin
      tweets = TweetSearch::Tweet.search(tags)

      content_type 'application/json'
      tweets.map(&:text).to_json
    rescue
      halt 404, "There is no tweet with hashtag #{tags}"
    end
  end
end
