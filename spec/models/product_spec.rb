# frozen_string_literal: true

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:sub_category) }
    it { should belong_to(:color) }
  end

  describe 'validations' do
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price_cents) }
  end

  # TODO: tests for price
end
