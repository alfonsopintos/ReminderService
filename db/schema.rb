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

ActiveRecord::Schema.define(version: 20141012171919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: true do |t|
    t.string  "access_token"
    t.integer "client_id"
  end

  add_index "api_keys", ["client_id"], name: "index_api_keys_on_client_id", using: :btree

  create_table "calls", force: true do |t|
    t.string  "cell_phone"
    t.text    "call_reminder"
    t.integer "event_recurrence_id"
  end

  add_index "calls", ["event_recurrence_id"], name: "index_calls_on_event_recurrence_id", using: :btree

  create_table "clients", force: true do |t|
    t.string  "name"
    t.integer "text_count",  default: 0
    t.integer "call_count",  default: 0
    t.integer "email_count", default: 0
  end

  create_table "emails", force: true do |t|
    t.string  "email_address"
    t.text    "email_reminder"
    t.integer "event_recurrence_id"
  end

  add_index "emails", ["event_recurrence_id"], name: "index_emails_on_event_recurrence_id", using: :btree

  create_table "event_recurrences", force: true do |t|
    t.string   "object_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "every"
    t.integer  "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", force: true do |t|
    t.string  "cell_phone"
    t.text    "text_reminder"
    t.integer "event_recurrence_id"
  end

  add_index "texts", ["event_recurrence_id"], name: "index_texts_on_event_recurrence_id", using: :btree

end
