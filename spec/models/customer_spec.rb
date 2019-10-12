# frozen_string_literal: true

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
  end
end
