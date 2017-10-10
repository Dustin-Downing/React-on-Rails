class Ingredient < ApplicationRecord
  belongs_to :recipe
  # validations
  validates_presence_of :name, :amount
end
