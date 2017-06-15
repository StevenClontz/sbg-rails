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

ActiveRecord::Schema.define(version: 20170615161728) do

  create_table "attempt_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "default_attempt_points"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "course_id"
    t.index ["course_id"], name: "index_attempt_categories_on_course_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.string   "note"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "attempted_on"
    t.integer  "student_id"
    t.integer  "standard_id"
    t.string   "mark"
    t.integer  "attempt_points_used"
    t.integer  "attempt_category_id"
    t.index ["attempt_category_id"], name: "index_attempts_on_attempt_category_id"
    t.index ["standard_id"], name: "index_attempts_on_standard_id"
    t.index ["student_id"], name: "index_attempts_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "uses_attempt_points", default: false
  end

  create_table "standard_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "satsifactory_limit"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "course_id"
    t.index ["course_id"], name: "index_standard_categories_on_course_id"
  end

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "standard_category_id"
    t.index ["standard_category_id"], name: "index_standards_on_standard_category_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school_identifier"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "course_id"
    t.integer  "attempt_points_earned"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

end
