class TwitterUpdateService

  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def update_user_data
    update_twitter_data_in_parallel
    ActionCable.server.broadcast("#{user.id}_data",
                                 "data updated for user")
  end

  def update_twitter_data_in_parallel
    Parallel.map(1..3, in_processes: 3, isolated: true) do |_|
      update_user_favorite_tweets
      update_user_trending_topics
      update_user_popular_tweeters
    end
  end

  def update_user_favorite_tweets
    favorite_tweets = client.favorites.take(5)
    favorite_tweets.each do |tweet|
      user_favorite_tweet = user.favorite_tweets.find_by(tweet_text: tweet.text)
      user.favorite_tweets.create(tweet_text: tweet.text,
                                  username: tweet.user.name,
                                  user_url: tweet.user.url.to_s) unless user_favorite_tweet
    end
  end

  def update_user_trending_topics
    trending_topics = client.local_trends.take(5)
    trending_topics.each do |topic|
      user_topic = user.trending_topics.find_by(name: topic.name)
      if user_topic
        user_topic.update_attributes(tweet_volume: topic.tweet_volume)
      else
        user.trending_topics.create(name: topic.name,
                                    tweet_volume: topic.tweet_volume)
      end
    end
  end

  def update_user_popular_tweeters
    popular_tweeters = client.home_timeline.take(5)
    popular_tweeters.each do |tweeter|
      user_tweeter = user.popular_tweeters.find_by(username: tweeter.user.name)
      if user_tweeter
        user_tweeter.update_attributes(follower_count: tweeter.user.followers_count)
      else
        user.popular_tweeters.create(username: tweeter.user.name,
                                     follower_count: tweeter.user.followers_count,
                                     twitter_id: tweeter.user.id,
                                     url: tweeter.user.url.to_s)
      end
    end
  end

  def client
    user.twitter_client
  end
end
