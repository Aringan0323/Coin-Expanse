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

ActiveRecord::Schema.define(version: 2021_10_10_213713) do

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

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "passwordDigest"
    t.string "encryptedBinanceApiKey"
    t.datetime "userSince"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
