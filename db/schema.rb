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

ActiveRecord::Schema.define(version: 20170830024941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_scrapers", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", id: :serial, force: :cascade do |t|
    t.string "multiverse_id", null: false
    t.integer "deck_id"
    t.string "name", null: false
    t.string "image_url"
    t.string "card_type"
    t.string "subtype"
    t.string "layout"
    t.integer "cmc"
    t.string "rarity"
    t.text "text"
    t.string "flavor"
    t.string "artist"
    t.string "number"
    t.string "power"
    t.string "toughness"
    t.integer "loyalty"
    t.string "watermark"
    t.string "border"
    t.boolean "timeshifted"
    t.string "hand"
    t.string "life"
    t.boolean "reserved"
    t.string "release_date"
    t.boolean "starter"
    t.text "original_text"
    t.string "original_type"
    t.string "source"
    t.integer "magic_set_id"
    t.index ["multiverse_id"], name: "index_cards_on_multiverse_id", unique: true
  end

  create_table "deck_cards", id: :serial, force: :cascade do |t|
    t.integer "deck_id"
    t.integer "card_id"
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "legal_format"
    t.string "deck_type"
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "magic_sets", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "gatherer_code"
    t.string "magiccards_info_code"
    t.string "border"
    t.string "set_type"
    t.string "block"
    t.string "release_date"
    t.boolean "online_only", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
