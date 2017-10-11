task :update_twitter_data => :environment do
  AllUserTwitterUpdateService.process
end
