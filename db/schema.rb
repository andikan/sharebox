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

ActiveRecord::Schema.define(version: 20140427100244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "assets", force: true do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.string   "file_id"
    t.string   "prev_file_id"
    t.string   "checksum"
    t.string   "url"
    t.string   "path"
    t.string   "uploaded_file_file_name"
    t.string   "uploaded_file_content_type"
    t.integer  "uploaded_file_file_size"
    t.datetime "uploaded_file_updated_at"
    t.datetime "deleted_at"
    t.hstore   "data",                       default: {},    null: false
    t.hstore   "uploaded_file_meta",         default: {},    null: false
    t.hstore   "chunks",                     default: [],    null: false, array: true
    t.boolean  "is_large",                   default: false
    t.boolean  "is_modified",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "random_hex"
    t.string   "original_file_name"
    t.string   "uploaded_file_fingerprint"
  end

  add_index "assets", ["folder_id"], name: "index_assets_on_folder_id", using: :btree
  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree

  create_table "folders", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["parent_id"], name: "index_folders_on_parent_id", using: :btree
  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "shared_folders", force: true do |t|
    t.integer  "user_id"
    t.string   "shared_email"
    t.integer  "shared_user_id"
    t.integer  "folder_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shared_folders", ["folder_id"], name: "index_shared_folders_on_folder_id", using: :btree
  add_index "shared_folders", ["shared_user_id"], name: "index_shared_folders_on_shared_user_id", using: :btree
  add_index "shared_folders", ["user_id"], name: "index_shared_folders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false,              comment: "Email"
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "name"
    t.string   "username"
    t.string   "displayname"
    t.string   "uid"
    t.string   "provider"
    t.string   "gender"
    t.string   "fb_token"
    t.hstore   "data",                   default: {}, null: false
    t.hstore   "mac_addresses",          default: [], null: false, array: true
    t.datetime "current_access_at"
    t.datetime "last_access_at"
    t.datetime "latest_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_token"], name: "index_users_on_fb_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
