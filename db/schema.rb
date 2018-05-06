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

ActiveRecord::Schema.define(version: 20180502102410) do

  create_table "bananas", force: :cascade do |t|
    t.integer "numid"
    t.string "color"
    t.string "ripeState"
    t.integer "ripeness"
    t.string "specialtype"
    t.string "slottime"
    t.boolean "ismaxripe"
    t.datetime "nexttime"
    t.integer "garden_id"
    t.integer "posx"
    t.integer "posy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_bananas_on_garden_id"
  end

  create_table "fields", force: :cascade do |t|
    t.integer "garden_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_fields_on_garden_id"
  end

  create_table "gardens", force: :cascade do |t|
    t.integer "sizex"
    t.integer "sizey"
    t.integer "scheduler_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scheduler_id"], name: "index_gardens_on_scheduler_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedulers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
