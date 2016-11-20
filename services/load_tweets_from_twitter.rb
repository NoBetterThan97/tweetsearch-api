# frozen_string_literal: true

# Loads data from Facebook group to database
class LoadGroupFromFB
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  TWITTER_REGEX = %r{twitter}

  register :validate_request_json, lambda { |request_body|
    begin
      url_representation = UrlRequestRepresenter.new(UrlRequest.new)
      Right(url_representation.from_json(request_body))
    rescue
      Left(Error.new(:bad_request, 'URL could not be resolved'))
    end
  }

  register :validate_request_url, lambda { |body_params|
    if (twitter_url = body_params['url']).nil?
      Left(:cannot_process, 'URL not supplied')
    else
      Right(twitter_url)
    end
  }

  register :retrieve_twitter_html, lambda { |fb_group_url|
    begin
      twitter_html = HTTP.get(twitter_url).body.to_s
      Right(twitter_html)
    rescue
      Left(Error.new(:bad_request, 'URL could not be resolved'))
    end
  }

  register :parse_tweet_id, lambda { |twitter_html|
    if (tweet_id_match = twitter_html.match(TWITTER_REGEX)).nil?
      Left(Error.new(:cannot_process, 'URL not recognized as tweets'))
    else
      Right(tweet_id_match[1])
    end
  }

  register :retrieve_tweet, lambda { |tweet_id|
    if Group.find(tw_id: tweet_id)
      Left(Error.new(:cannot_process, 'Tweet already exists'))
    else
      Right(TweetSearch::Tweet.search(tags: tags))
    end
  }

  register :create_tweets, lambda { |new_tweet|
    tweet = Tweets.create(tweet_id: new_tweet.id, created_at: Time.now, text: new_tweet.text)
    tweet.text.each do |new_tweet|
      write_tweet(tweet)
    end
    Right(tweet)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :validate_request_url
      step :retrieve_twitter_html
      step :parse_tweet_id
      step :retrieve_tweet
      step :create_tweets
    end.call(params)
  end

  private_class_method

  def self.write_tweet(tweet)
    tweet.add_tweet(
      tweet_id:                    new_tweet.id,
      created_at:                  Time.now,
      text:                        new_tweet.text,
          )
  end
end
