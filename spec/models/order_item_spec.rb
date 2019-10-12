# frozen_string_literal: true

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:price_cents) }
  end

  # TODO: tests for price
end
