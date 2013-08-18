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

ActiveRecord::Schema.define(version: 20130818154908) do

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_updated_by_user_id"
    t.boolean  "op_updated"
  end

  create_table "issue_state_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_states", force: true do |t|
    t.integer  "issue_state_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.integer  "conversation_id"
  end

  create_table "participations", force: true do |t|
    t.integer  "issue_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
  end

  create_table "registered_webhook_events", force: true do |t|
    t.integer  "registered_webhook_id"
    t.integer  "webhook_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registered_webhooks", force: true do |t|
    t.string   "name"
    t.text     "url"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setting_stores", force: true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sent_message_count",     default: 0
    t.integer  "received_message_count", default: 0
    t.text     "name"
    t.integer  "current_issue_state_id"
    t.integer  "role_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "webhook_events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
