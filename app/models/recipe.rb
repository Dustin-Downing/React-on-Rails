class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  # validations
  validates_presence_of :name, :description, :time
end
