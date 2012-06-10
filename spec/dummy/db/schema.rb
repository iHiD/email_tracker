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

ActiveRecord::Schema.define(:version => 20120610205858) do

  create_table "email_tracker_email_instances", :force => true do |t|
    t.integer  "email_id",      :null => false
    t.string   "email_address", :null => false
    t.string   "url_code",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "opened_at"
  end

  create_table "email_tracker_emails", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "mailer",      :null => false
    t.string   "action",      :null => false
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "email_tracker_link_instances", :force => true do |t|
    t.integer  "link_id",           :null => false
    t.integer  "email_instance_id", :null => false
    t.datetime "clicked_at"
  end

  create_table "email_tracker_links", :force => true do |t|
    t.string   "url",                       :null => false
    t.integer  "num_clicks", :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "subscriptions", :force => true do |t|
  end

end
