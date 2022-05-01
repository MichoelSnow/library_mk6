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

ActiveRecord::Schema.define(version: 2022_04_28_023704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.string "barcode", limit: 20
    t.string "first_name"
    t.string "last_name"
    t.boolean "volunteer", default: false
    t.string "handle"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bggcategory", id: false, force: :cascade do |t|
    t.integer "cat_id", null: false
    t.text "cat_name"
  end

  create_table "bggfamily", id: false, force: :cascade do |t|
    t.integer "fam_id", null: false
    t.text "fam_name"
  end

  create_table "bggmechanic", id: false, force: :cascade do |t|
    t.integer "mech_id", null: false
    t.text "mech_name"
  end

  create_table "checkouts", force: :cascade do |t|
    t.integer "game_id"
    t.integer "attendee_id"
    t.integer "event_id"
    t.datetime "check_out_time"
    t.datetime "return_time"
    t.boolean "closed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.date "start_date"
    t.date "end_date"
    t.boolean "current", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "utc_offset"
    t.datetime "setup_computer_tz"
    t.datetime "setup_scan_games"
    t.datetime "setup_add_new_games"
    t.datetime "setup_library_server"
    t.datetime "reset_setup"
  end

  create_table "events_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name", limit: 255
    t.string "location", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.boolean "current"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "utc_offset"
    t.datetime "setup_computer_tz"
    t.datetime "setup_scan_games"
    t.datetime "setup_add_new_games"
    t.datetime "setup_library_server"
    t.datetime "reset_setup"
  end

  create_table "games", force: :cascade do |t|
    t.string "barcode", limit: 20
    t.integer "title_id"
    t.boolean "culled", default: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "barcode", limit: 20
    t.integer "title_id"
    t.boolean "culled"
    t.integer "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.text "name"
    t.text "description"
    t.boolean "deleted", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.integer "game_id"
    t.integer "group_id"
    t.datetime "check_out_time"
    t.datetime "return_time"
    t.boolean "closed", default: false
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metadata", id: false, force: :cascade do |t|
    t.integer "pax_id", null: false
    t.integer "min_player"
    t.integer "max_player"
    t.integer "year_pub"
    t.integer "playtime"
    t.integer "min_age"
    t.decimal "avg_rating"
    t.decimal "weight"
    t.text "families"
    t.text "mechanics"
    t.text "categories"
    t.text "description"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "setups", force: :cascade do |t|
    t.integer "game_id"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suggestions", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.text "title"
    t.integer "votes", default: 0
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teardowns", force: :cascade do |t|
    t.integer "game_id"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "title"
    t.integer "publisher_id"
    t.boolean "valuable", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "titles_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "title", limit: 255
    t.integer "publisher_id"
    t.boolean "valuable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_games", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.text "title"
    t.integer "quantity", default: 0
    t.boolean "expansion", default: false
    t.text "notes"
    t.boolean "deleted", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password_digest"
    t.string "remember_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
