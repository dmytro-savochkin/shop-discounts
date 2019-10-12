# frozen_string_literal: true

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:order_discounts).dependent(:destroy) }
  end

  it { should define_enum_for(:status).with_values(created: 0, confirmed: 1, fulfilled: 2) }

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:total_cents) }
    it { should validate_inclusion_of(:status).in_array([0, 1, 2]) }
  end

  describe '#confirmed_or_higher?' do
    subject { order.confirmed_or_higher }

    let(:order) { build :order }

    context 'when status is created' do
      let(:status) { 'created' }

      it { is_expected.to be_falsey }
    end

    context 'when status is confirmed' do
      let(:status) { 'confirmed' }

      it { is_expected.to be_truthy }
    end

    context 'when status is fulfilled' do
      let(:status) { 'fulfilled' }

      it { is_expected.to be_truthy }
    end
  end

  # TODO: tests for price
end
