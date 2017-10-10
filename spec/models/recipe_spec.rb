require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { should have_many(:ingredients).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:time) }
end
