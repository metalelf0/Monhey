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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131105140225) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "color_id"
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "colors", :force => true do |t|
    t.string "code"
  end

  create_table "expenses", :force => true do |t|
    t.string   "description"
    t.float    "amount"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.date     "date"
    t.integer  "category_id"
    t.integer  "account_id"
    t.integer  "user_id"
    t.boolean  "include_in_budget", :default => true
  end

  add_index "expenses", ["user_id"], :name => "index_expenses_on_user_id"

  create_table "movements", :force => true do |t|
    t.integer  "from_account_id"
    t.integer  "to_account_id"
    t.date     "date"
    t.integer  "amount"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "profile_pic"
  end

end
