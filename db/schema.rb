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

ActiveRecord::Schema.define(:version => 20100908051157) do

  create_table "foods", :force => true do |t|
    t.string   "old_pk",            :limit => 5
    t.string   "long_desc"
    t.string   "short_desc"
    t.string   "common_name"
    t.string   "manufacturer_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["old_pk"], :name => "index_foods_on_old_pk"

  create_table "ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "order_of"
    t.float    "amount"
    t.string   "unit"
    t.string   "name"
    t.string   "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrient_definitions", :force => true do |t|
    t.integer  "nutrient_id"
    t.string   "units"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nutrient_definitions", ["nutrient_id"], :name => "index_nutrient_definitions_on_nutrient_id"

  create_table "nutrients", :force => true do |t|
    t.integer  "food_id"
    t.string   "old_pk",     :limit => 3
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nutrients", ["food_id"], :name => "index_nutrients_on_food_id"
  add_index "nutrients", ["old_pk"], :name => "index_nutrients_on_old_pk"

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.integer  "servings"
    t.text     "description"
    t.text     "directions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weights", :force => true do |t|
    t.integer  "food_id"
    t.float    "amount"
    t.string   "measure_desc"
    t.float    "gm_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weights", ["food_id"], :name => "index_weights_on_food_id"

end
