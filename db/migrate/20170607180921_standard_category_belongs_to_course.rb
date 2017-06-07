class StandardCategoryBelongsToCourse < ActiveRecord::Migration[5.0]
  def change
    remove_reference :standards, :category, foreign_key: true
    add_reference :standards, :standard_category, foreign_key: true
    add_reference :standard_categories, :course, foreign_key: true
  end
end
