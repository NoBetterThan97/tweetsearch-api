# frozen_string_literal: true

# Represents overall group information for JSON API output
class TweetRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :created_at
  property :text
end
