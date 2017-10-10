require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it { should belong_to(:recipe) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:amount) }
end
