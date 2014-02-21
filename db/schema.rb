# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140203203638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debts", force: true do |t|
    t.float    "amount"
    t.integer  "debtor_id",   null: false
    t.integer  "creditor_id", null: false
    t.integer  "expense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "image_url"
    t.integer  "owner_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", using: :btree

  create_table "expenses", force: true do |t|
    t.integer  "event_id"
    t.float    "price"
    t.text     "currency"
    t.text     "title"
    t.text     "description"
    t.date     "due_date"
    t.text     "image_url"
    t.integer  "payer_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenses", ["event_id"], name: "index_expenses_on_event_id", using: :btree

  create_table "social_profiles", force: true do |t|
    t.text     "name"
    t.text     "surname"
    t.integer  "vk_id"
    t.text     "vk_access_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
