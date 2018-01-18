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

ActiveRecord::Schema.define(version: 20180118213002) do

  create_table "assessments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
    t.index [nil, nil], name: "index_assessments_on_assessment_id_and_standard_id"
  end

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

  create_table "covered_standards", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assessment_id"
    t.integer  "standard_id"
    t.index ["assessment_id", "standard_id"], name: "index_covered_standards_on_assessment_id_and_standard_id"
  end

  create_table "exercise_versions", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "covered_standard_id"
    t.integer  "exercise_id"
    t.index ["covered_standard_id", "exercise_id"], name: "index_exercise_versions_on_covered_standard_id_and_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.text     "description"
    t.text     "solution"
    t.integer  "standard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["standard_id"], name: "index_exercises_on_standard_id"
  end

  create_table "grade_specifications", force: :cascade do |t|
    t.string   "grade"
    t.string   "requirement"
    t.integer  "amount"
    t.integer  "standard_category_id"
    t.integer  "course_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["course_id"], name: "index_grade_specifications_on_course_id"
    t.index ["standard_category_id"], name: "index_grade_specifications_on_standard_category_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "standard_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "satisfactory_limit"
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
    t.integer  "section_id"
    t.index ["course_id"], name: "index_students_on_course_id"
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  create_table "version_assignments", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "exercise_version_id"
    t.integer  "student_id"
    t.index ["exercise_version_id", "student_id"], name: "index__version_assignment__exercise_version__student"
  end

end
