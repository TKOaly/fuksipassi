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

ActiveRecord::Schema.define(version: 20170828124730) do

  create_table "events", force: :cascade do |t|
    t.string   "name",       null: false
    t.date     "date"
    t.string   "event_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year_id"
    t.index ["year_id"], name: "index_events_on_year_id"
  end

  create_table "hidden_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_hidden_events_on_event_id"
    t.index ["user_id"], name: "index_hidden_events_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "en_name",    null: false
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "points"
    t.string   "description"
    t.integer  "from_id"
    t.integer  "to_id"
    t.boolean  "points_hidden"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["from_id"], name: "index_notes_on_from_id"
    t.index ["to_id"], name: "index_notes_on_to_id"
  end

  create_table "participation_requests", force: :cascade do |t|
    t.integer  "acceptor_id"
    t.integer  "participant_id"
    t.string   "description"
    t.integer  "participation_id"
    t.boolean  "accepted"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["acceptor_id"], name: "index_participation_requests_on_acceptor_id"
    t.index ["participant_id"], name: "index_participation_requests_on_participant_id"
    t.index ["participation_id"], name: "index_participation_requests_on_participation_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "points"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "event_id"
    t.string   "description"
    t.integer  "participation_type"
    t.index ["event_id"], name: "index_participations_on_event_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "irc_nick",                            null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "year_id"
    t.string   "image"
    t.integer  "language_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["language_id"], name: "index_users_on_language_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["year_id"], name: "index_users_on_year_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer  "year",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
