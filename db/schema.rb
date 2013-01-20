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

ActiveRecord::Schema.define(:version => 20130119015829) do

  create_table "event_people", :force => true do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.integer  "consume"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pay"
  end

  create_table "event_types", :force => true do |t|
    t.string "name"
  end

  create_table "event_users", :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.decimal "pay"
    t.decimal "consume"
  end

  create_table "events", :force => true do |t|
    t.integer  "place_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "event_type_id"
  end

  create_table "groups", :force => true do |t|
    t.string "name"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "group_id"], :name => "index_memberships_on_user_id_and_group_id", :unique => true

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gender"
  end

  create_table "places", :force => true do |t|
    t.string "name"
    t.string "address"
  end

  create_table "users", :force => true do |t|
    t.string "name"
  end

end
