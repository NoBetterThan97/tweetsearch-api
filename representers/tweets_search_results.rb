# frozen_string_literal: true
require_relative 'tweets'

# Represents overall group information for JSON API output
class TweetsSearchResultsRepresenter < Roar::Decorator
  include Roar::JSON

  property :search_terms_used
  property :tags
  collection :tweets, extend: TweetRepresenter, class: Tweets
end
