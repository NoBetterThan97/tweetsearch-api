# frozen_string_literal: true

class FindTweet
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    if ( tweet = Tweets.find(id: params[:id])).nil?
      Left(Error.new(:not_found, 'Tweet not found'))
    else
      Right(tweet)
    end
  end
end
