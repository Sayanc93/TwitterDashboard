# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171010222708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_tweets", force: :cascade do |t|
    t.text "tweet_text"
    t.string "username"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "user_id"], name: "index_favorite_tweets_on_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_favorite_tweets_on_user_id"
  end

  create_table "popular_tweeters", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "username", limit: 255
    t.string "follower_count"
    t.bigint "user_id"
    t.string "twitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_popular_tweeters_on_user_id"
    t.index ["username", "user_id"], name: "index_popular_tweeters_on_username_and_user_id", unique: true
  end

  create_table "trending_topics", force: :cascade do |t|
    t.string "name"
    t.string "tweet_volume"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id", "user_id"], name: "index_trending_topics_on_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_trending_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", limit: 255
    t.string "token"
    t.string "secret"
    t.string "name", limit: 255
    t.string "provider"
    t.string "username"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "favorite_tweets", "users"
  add_foreign_key "popular_tweeters", "users"
  add_foreign_key "trending_topics", "users"
end
