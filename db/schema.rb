# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_06_050252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_tickers", force: :cascade do |t|
    t.bigint "coin_id"
    t.float "avgPrice"
    t.float "bidPrice"
    t.float "bidQty"
    t.float "askPrice"
    t.float "askQty"
    t.datetime "timestamp"
    t.index ["coin_id"], name: "index_book_tickers_on_coin_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "symbol"
    t.string "binance_symbol"
    t.string "name"
  end

  create_table "day_summaries", force: :cascade do |t|
    t.bigint "coin_id"
    t.float "priceChange"
    t.float "priceChangePercent"
    t.float "weightedAvgPrice"
    t.float "prevClosePrice"
    t.float "lastPrice"
    t.float "lastQty"
    t.float "bidPrice"
    t.float "askPrice"
    t.float "openPrice"
    t.float "highPrice"
    t.float "lowPrice"
    t.float "volume"
    t.datetime "openTime"
    t.datetime "closeTime"
    t.integer "tradeCount"
    t.index ["coin_id"], name: "index_day_summaries_on_coin_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.bigint "coin_id", null: false
    t.string "name"
    t.string "data"
    t.string "interval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_indicators_on_coin_id"
  end

  create_table "news_articles", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "description"
    t.string "url"
    t.string "image_url"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "symbol"
    t.string "side"
    t.float "amount"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "portfolio_coin_join_tables", force: :cascade do |t|
    t.bigint "coin_id"
    t.bigint "portfolio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_portfolio_coin_join_tables_on_coin_id"
    t.index ["portfolio_id"], name: "index_portfolio_coin_join_tables_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id"
    t.float "initialValue"
    t.datetime "creationTimestamp"
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "strategies", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "coin_name"
    t.string "side"
    t.float "amount"
    t.string "algorithm"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "raw"
    t.index ["user_id"], name: "index_strategies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "encryptedBinanceApiKey"
    t.string "email"
    t.string "full_name"
    t.datetime "userSince"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "binance_public_key"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  add_foreign_key "indicators", "coins"
  add_foreign_key "orders", "users"
end
