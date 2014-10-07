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

ActiveRecord::Schema.define(version: 20141007215110) do

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
  end

  create_table "calls", force: true do |t|
    t.string   "cell_phone"
    t.text     "call_reminder"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_recurrence_id"
  end

  add_index "calls", ["event_recurrence_id"], name: "index_calls_on_event_recurrence_id"

  create_table "emails", force: true do |t|
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_recurrence_id"
    t.text     "email_reminder"
  end

  add_index "emails", ["event_recurrence_id"], name: "index_emails_on_event_recurrence_id"

  create_table "event_recurrences", force: true do |t|
    t.string   "object_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "every"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interval"
  end

  create_table "texts", force: true do |t|
    t.string   "cell_phone"
    t.text     "text_reminder"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_recurrence_id"
  end

  add_index "texts", ["event_recurrence_id"], name: "index_texts_on_event_recurrence_id"

end
