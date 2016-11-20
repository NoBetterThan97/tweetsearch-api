# frozen_string_literal: true

# Search query for postings in a group by optional keywords
class SearchTweets
  def self.call(hashtag)
    hashtag&.any? ? search_tweets(hashtag) : tweet.text
  end

  private_class_method

  def self.search_tweets(hashtag)
    Tweets.where(where_clause(tag)).all
  end

  def self.where_clause(hashtag)
    hashtag.map do |tag|
      Sequel.ilike(:text, "%#{tag}%")
    end.inject(&:|)
  end
end
