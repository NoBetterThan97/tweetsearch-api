# frozen_string_literal: true
require 'sinatra'
require 'econfig'
require 'tweetsearch'

# GroupAPI web service
class TweetSearchAPI < Sinatra::Base
  extend Econfig::Shortcut

  Econfig.env = settings.environment.to_s
  Econfig.root = settings.root

  TweetSearch::TwitterClient.config.update(access_token: config.access_token)

  API_VER = 'api/v0.1'

  get '/?' do
    "TweetSearchAPI latest version endpoints are at: /#{API_VER}/"
  end

  get "/#{API_VER}/tweets/:tags/?" do
    begin
      tags = params[:tags].split(',').map { |tag| "##{tag}" }
      tweets = TweetSearch::Tweet.search(tags)
      return halt(404, "There is no tweet with hashtag #{tags}") if tweets.empty?

      content_type 'application/json'
      tweets.map(&:text).to_json
    rescue
      halt 404, "There is no tweet with hashtag #{tags}"
    end
  end
end
