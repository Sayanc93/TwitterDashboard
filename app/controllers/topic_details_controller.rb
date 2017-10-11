class TopicDetailsController < ApplicationController
  def show
    @topic = current_user.trending_topics.find_by(id: params[:id])
    @topic_tweets = client.search(@topic.name, result_type: "recent").take(5)
  end

  private

    def client
      current_user.twitter_client
    end
end
