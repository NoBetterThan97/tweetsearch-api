# frozen_string_literal: true
require 'sinatra'
require 'econfig'
require 'tweetsearch'

# GroupAPI web service
class TweetSearchAPI < Sinatra::Base

  API_VER = 'api/v0.1'

  get '/?' do
    "TweetSearchAPI latest version endpoints are at: /#{API_VER}/"
  end



end
