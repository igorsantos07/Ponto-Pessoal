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

ActiveRecord::Schema.define(:version => 5) do

  create_table "accounts", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
    t.string "login"
  end

  add_index "accounts", ["login"], :name => "index_accounts_on_login", :unique => true

  create_table "workdays", :force => true do |t|
    t.date    "day"
    t.string  "enter"
    t.string  "go_lunch"
    t.string  "back_lunch"
    t.string  "out",        :limit => nil
    t.integer "account_id"
  end

  add_index "workdays", ["account_id", "day"], :name => "index_workdays_on_account_id_and_day"

end
