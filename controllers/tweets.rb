# frozen_string_literal: true
require 'sinatra'
require 'tweetsearch'

# GroupAPI web service
class TweetSearchAPI < Sinatra::Base

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
