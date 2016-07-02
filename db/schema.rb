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

ActiveRecord::Schema.define(version: 20160702170133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.string   "list"
    t.string   "url"
    t.string   "trello_identifier"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "sprint_id"
    t.string   "type"
    t.integer  "estimated_size"
  end

  add_index "cards", ["sprint_id"], name: "index_cards_on_sprint_id", using: :btree

  create_table "cards_labels", id: false, force: :cascade do |t|
    t.integer "card_id",  null: false
    t.integer "label_id", null: false
  end

  add_index "cards_labels", ["card_id", "label_id"], name: "index_cards_labels_on_card_id_and_label_id", using: :btree
  add_index "cards_labels", ["label_id", "card_id"], name: "index_cards_labels_on_label_id_and_card_id", using: :btree

  create_table "cards_members", id: false, force: :cascade do |t|
    t.integer "card_id",   null: false
    t.integer "member_id", null: false
  end

  add_index "cards_members", ["card_id", "member_id"], name: "index_cards_members_on_card_id_and_member_id", using: :btree
  add_index "cards_members", ["member_id", "card_id"], name: "index_cards_members_on_member_id_and_card_id", using: :btree

  create_table "casein_admin_users", force: :cascade do |t|
    t.string   "login",                           null: false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        default: 0, null: false
    t.string   "crypted_password",                null: false
    t.string   "password_salt",                   null: false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         default: 0, null: false
    t.integer  "failed_login_count",  default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", force: :cascade do |t|
    t.string   "color"
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "trello_identifier"
  end

  create_table "members", force: :cascade do |t|
    t.string   "full_name"
    t.string   "trello_identifier"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "sprints", force: :cascade do |t|
    t.date     "start"
    t.date     "finish"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cards", "sprints"
end
