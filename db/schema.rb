# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_14_081436) do
  create_table "cat_profiles", force: :cascade do |t|
    t.integer "pet_id", null: false
    t.boolean "lost_tracker", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_cat_profiles_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "pet_type", null: false
    t.string "tracker_type", null: false
    t.integer "owner_id", null: false
    t.boolean "in_zone", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cat_profiles", "pets"
end
