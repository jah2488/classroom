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

ActiveRecord::Schema.define(version: 20150406171318) do

  create_table "assignments", force: :cascade do |t|
    t.string   "title"
    t.text     "info"
    t.datetime "due_date"
    t.integer  "cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assignments", ["cohort_id"], name: "index_assignments_on_cohort_id"

  create_table "checkins", force: :cascade do |t|
    t.integer  "student_id"
    t.boolean  "late",       default: false
    t.boolean  "absent",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "checkins", ["student_id"], name: "index_checkins_on_student_id"

  create_table "cohorts", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "instructor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "cohorts", ["instructor_id"], name: "index_cohorts_on_instructor_id"

  create_table "instructors", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "office_hours_start"
    t.datetime "office_hours_end"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
  end

  add_index "instructors", ["email"], name: "index_instructors_on_email", unique: true
  add_index "instructors", ["reset_password_token"], name: "index_instructors_on_reset_password_token", unique: true

  create_table "ratings", force: :cascade do |t|
    t.integer  "amount"
    t.text     "notes"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ratings", ["submission_id"], name: "index_ratings_on_submission_id"

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "github"
    t.string   "phone"
    t.string   "blog"
    t.text     "bio"
    t.integer  "cohort_id",                           null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "students", ["cohort_id"], name: "index_students_on_cohort_id"
  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "submissions", force: :cascade do |t|
    t.string   "link"
    t.text     "notes"
    t.boolean  "completed"
    t.boolean  "late"
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id"
  add_index "submissions", ["student_id"], name: "index_submissions_on_student_id"

end
