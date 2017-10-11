class AllUserTwitterUpdateService
  def self.process
    User.find_each do |user|
      TwitterUpdateJob.perform_later(user.id)
    end
  end
end
