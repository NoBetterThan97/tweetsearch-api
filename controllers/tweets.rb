# frozen_string_literal: true
require 'sinatra'
require 'tweetsearch'

# GroupAPI web service
class TweetSearchAPI < Sinatra::Base

  get "/#{API_VER}/tweets/:tags/?" do

    results = SearchTweets.call(params)

    if results.success?
      TweetsSearchResultsRepresenter.new(results.value).to_json
    else
      ErrorRepresenter.new(results.value).to_status_response
    end
  end

  put "/#{API_VER}/tweets/:id/?" do
    result = UpdateTweetFromTWITTER.call(params)

    if result.success?
      TweetRepresenter.new(result.value).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

    post "/#{API_VER}/tweets/?" do
      result = LoadTweetFromTWITTER.call(request.body.read)

      if result.success?
        TweetRepresenter.new(result.value).to_json
      else
        ErrorRepresenter.new(result.value).to_status_response
      end
    end
  end
