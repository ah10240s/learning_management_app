# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_09_115456) do

  create_table "membership_subject_groups", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "subject_group_id", null: false
    t.datetime "joined_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_group_id"], name: "index_membership_subject_groups_on_subject_group_id"
    t.index ["subject_id"], name: "index_membership_subject_groups_on_subject_id"
  end

  create_table "studyplans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subject_id", null: false
    t.datetime "start_daytime", null: false
    t.boolean "done_flag", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "end_daytime", null: false
    t.index ["subject_id"], name: "index_studyplans_on_subject_id"
    t.index ["user_id"], name: "index_studyplans_on_user_id"
  end

  create_table "subject_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subject_groups_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.text "subject_name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.boolean "invite_possible_flag", default: true
    t.text "invite_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "membership_subject_groups", "subject_groups"
  add_foreign_key "membership_subject_groups", "subjects"
  add_foreign_key "studyplans", "subjects"
  add_foreign_key "studyplans", "users"
  add_foreign_key "subject_groups", "users"
  add_foreign_key "subjects", "users"
end
