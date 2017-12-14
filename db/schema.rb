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

ActiveRecord::Schema.define(version: 20171210045408) do

  create_table "class_rooms", force: :cascade do |t|
    t.integer  "person_price",                 null: false
    t.string   "style_name",                   null: false
    t.integer  "expect_count",                 null: false
    t.integer  "can_add_bed",                  null: false
    t.float    "discount_rate",  default: 1.0, null: false
    t.float    "surcharge_rate", default: 1.0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "user_id",                         null: false
    t.string   "password",                        null: false
    t.string   "name",                            null: false
    t.string   "address",                         null: false
    t.integer  "tel",                             null: false
    t.integer  "age",                             null: false
    t.string   "email",                           null: false
    t.boolean  "admin_authority", default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "plan_rooms", force: :cascade do |t|
    t.integer  "room_id",    null: false
    t.integer  "plan_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "apply_count", null: false
    t.integer  "price",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "room_id",     null: false
    t.integer  "plan_id",     null: false
    t.integer  "member_id",   null: false
    t.integer  "guest_count", null: false
    t.integer  "sum_price",   null: false
    t.date     "start_date",  null: false
    t.date     "end_date",    null: false
    t.boolean  "is_extend",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "room_id",     null: false
    t.integer  "room_number", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
