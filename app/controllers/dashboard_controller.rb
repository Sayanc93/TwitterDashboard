class DashboardController < ApplicationController
  def index
    TwitterUpdateJob.perform_later(current_user.id) if current_user.trending_topics.empty?
  end
end
