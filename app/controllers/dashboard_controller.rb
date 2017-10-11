class DashboardController < ApplicationController
  def index
    TwitterUpdateJob.perform_now(current_user.id) if current_user.trending_topics.empty?
  end
end
