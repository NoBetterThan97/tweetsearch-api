# frozen_string_literal: true

# configure based on environment
class TweetSearchAPI < Sinatra::Base
extend Econfig::Shortcut

Econfig.env = settings.environment.to_s
Econfig.root = settings.root

TweetSearch::TwitterClient.config.update(access_token: config.access_token)

API_VER = 'api/v0.1'

get '/?' do
  "TweetSearchAPI latest version endpoints are at: /#{API_VER}/"
end

end
