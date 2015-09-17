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

ActiveRecord::Schema.define(version: 20150910161017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "adjustments", force: :cascade do |t|
    t.integer  "checkin_id"
    t.string   "state",      default: "OPENED"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "adjustments", ["checkin_id"], name: "index_adjustments_on_checkin_id", using: :btree

  create_table "assignment_tags", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "assignment_tags", ["assignment_id"], name: "index_assignment_tags_on_assignment_id", using: :btree
  add_index "assignment_tags", ["tag_id"], name: "index_assignment_tags_on_tag_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.string   "title"
    t.text     "info"
    t.datetime "due_date"
    t.integer  "cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assignments", ["cohort_id"], name: "index_assignments_on_cohort_id", using: :btree

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "icon_image_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "campuses", force: :cascade do |t|
    t.string "name"
    t.float  "latitude"
    t.float  "longitude"
    t.string "time_zone", default: "Central Time (US & Canada)"
  end

  create_table "checkins", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "day_id"
  end

  add_index "checkins", ["day_id"], name: "index_checkins_on_day_id", using: :btree
  add_index "checkins", ["student_id"], name: "index_checkins_on_student_id", using: :btree

  create_table "cohorts", force: :cascade do |t|
    t.string   "name"
    t.integer  "instructor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "start_time"
    t.integer  "campus_id"
  end

  add_index "cohorts", ["instructor_id"], name: "index_cohorts_on_instructor_id", using: :btree

  create_table "cohorts_instructors", id: false, force: :cascade do |t|
    t.integer "cohort_id",     null: false
    t.integer "instructor_id", null: false
  end

  add_index "cohorts_instructors", ["cohort_id"], name: "index_cohorts_instructors_on_cohort_id", using: :btree
  add_index "cohorts_instructors", ["instructor_id"], name: "index_cohorts_instructors_on_instructor_id", using: :btree

  create_table "days", force: :cascade do |t|
    t.integer  "cohort_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "override_code", default: "d80c", null: false
    t.datetime "start"
  end

  add_index "days", ["cohort_id"], name: "index_days_on_cohort_id", using: :btree

  create_table "instructors", force: :cascade do |t|
    t.string   "phone"
    t.datetime "office_hours_start"
    t.datetime "office_hours_end"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "amount"
    t.text     "notes"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ratings", ["submission_id"], name: "index_ratings_on_submission_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "day_id"
    t.integer  "participation"
    t.string   "participation_comments"
    t.integer  "effort"
    t.string   "effort_comments"
    t.integer  "skill"
    t.string   "skill_comments"
    t.integer  "overall"
    t.string   "overall_comments"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string   "phone"
    t.string   "blog"
    t.text     "bio"
    t.integer  "cohort_id",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "twitter"
    t.datetime "last_active_at"
    t.integer  "user_id"
  end

  add_index "students", ["cohort_id"], name: "index_students_on_cohort_id", using: :btree

  create_table "submission_badges", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "submission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "submission_badges", ["badge_id"], name: "index_submission_badges_on_badge_id", using: :btree
  add_index "submission_badges", ["submission_id"], name: "index_submission_badges_on_submission_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.string   "link"
    t.text     "notes"
    t.integer  "state",         default: 1,     null: false
    t.boolean  "completed",     default: false
    t.boolean  "late",          default: false
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id", using: :btree
  add_index "submissions", ["student_id"], name: "index_submissions_on_student_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "name"
    t.string   "github"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "adjustments", "checkins"
  add_foreign_key "assignment_tags", "assignments"
  add_foreign_key "assignment_tags", "tags"
  add_foreign_key "assignments", "cohorts"
  add_foreign_key "checkins", "days"
  add_foreign_key "checkins", "students"
  add_foreign_key "cohorts", "instructors"
  add_foreign_key "days", "cohorts"
  add_foreign_key "ratings", "submissions"
  add_foreign_key "students", "cohorts"
  add_foreign_key "submission_badges", "badges"
  add_foreign_key "submission_badges", "submissions"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "students"
end
