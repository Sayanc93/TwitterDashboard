class CreateFavoriteTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_tweets do |t|
      t.text :tweet_text
      t.string :username
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :favorite_tweets, [:id, :user_id], unique: true
  end
end
