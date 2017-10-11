class TwitterUpdateJob < ApplicationJob

  def perform(user_id = nil)
    user = User.find(user_id)
    update_user_twitter_data(user)
  end

  def update_user_twitter_data user = nil
    update_service = TwitterUpdateService.new(user)
    update_service.update_user_data
  end
end
