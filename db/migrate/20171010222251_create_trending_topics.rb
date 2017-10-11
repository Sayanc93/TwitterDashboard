class CreateTrendingTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :trending_topics do |t|
      t.string :name
      t.string :tweet_volume
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :trending_topics, [:id, :user_id], unique: true
  end
end
