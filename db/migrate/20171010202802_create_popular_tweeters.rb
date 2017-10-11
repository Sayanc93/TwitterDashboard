class CreatePopularTweeters < ActiveRecord::Migration[5.1]
  def change
    create_table :popular_tweeters do |t|
      t.string :name, limit: 255
      t.string :username, limit: 255
      t.string :follower_count
      t.references :user, foreign_key: true
      t.string :twitter_id
      t.string :url

      t.timestamps
    end
    add_index :popular_tweeters, [:username, :user_id], unique: true
  end
end
