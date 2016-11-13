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

  get "/#{API_VER}/tweets/:id/?" do
    tweet_id = params[:id]
    begin
      tweet = Tweets.find(id: tweet_id)

      content_type 'application/json'
      { id: tweet.id, text: tweet.text }.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Tweet id (id: #{tweet_id}) not found"
    end
  end


  post "/#{API_VER}/tweets/?" do
    tweet_id = params['tweet_id']
    created_at = params['created_at']
    text = params['text']
    new_tweet = Tweets.create(tweet_id: tweet_id, created_at: created_at, text: text)

  end


end
