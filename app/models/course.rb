class Course < ApplicationRecord
  has_many :students
  has_many :standards, through: :standard_category
  has_many :standard_categories
