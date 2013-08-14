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

ActiveRecord::Schema.define(version: 20130723203638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.text     "title"
    t.string   "owner_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.integer  "event_id"
    t.float    "amount"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenses", ["event_id"], name: "index_expenses_on_event_id", using: :btree

  create_table "expenses_users", id: false, force: true do |t|
    t.integer "expense_id"
    t.integer "user_id"
  end

  add_index "expenses_users", ["expense_id", "user_id"], name: "index_expenses_users_on_expense_id_and_user_id", using: :btree

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["event_id"], name: "index_members_on_event_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "socials", force: true do |t|
    t.integer  "user_id"
    t.text     "name"
    t.text     "surname"
    t.integer  "vk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vk_token"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
