class User < ApplicationRecord
  has_many :popular_tweeters
  has_many :favorite_tweets
  has_many :trending_topics

  # Create user with credentials if it doesn't already exist in DB.
  def self.from_omniauth(auth)
    current_user = where(uid: auth.uid)
                    .first_or_create(name: auth.info.name,
                                     token: auth.credentials.token,
                                     secret: auth.credentials.secret,
                                     provider: auth.provider,
                                     location: auth.info.location,
                                     username: auth.extra.access_token.params[:screen_name])
    current_user
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = self.token
      config.access_token_secret = self.secret
    end
  end
end
