class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    drop_table :assessments do |t|
      t.string   "name"
      t.string   "description"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.integer  "standard_id"
      t.integer  "exam_id"
      t.index ["exam_id"], name: "index_assessments_on_exam_id"
      t.index ["standard_id"], name: "index_assessments_on_standard_id"
    end

    drop_table :exams do |t|
      t.string   "name"
      t.string   "description"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    remove_column :students, :irq_grade, :integer
    remove_column :students, :trq_grade, :integer
    remove_column :students, :pes_grade, :integer
    remove_column :students, :participation_adjustment, :integer

    remove_column :standards, :category, :integer

    remove_column :attempts, :assessment_id, :integer
    add_belongs_to :attempts, :standard
  end
end
