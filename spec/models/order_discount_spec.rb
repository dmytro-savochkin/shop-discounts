# frozen_string_literal: true

RSpec.describe OrderDiscount, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end

  describe 'validations' do
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:discount_type) }

    describe '#validate_discount_type?' do
      subject { order_discount.errors[:discount_type] }

      let(:order_discount) { build :order_discount }

      context 'when discount_type is LateFoodDiscounter' do
        let(:discount_type) { 'LateFoodDiscounter' }

        it { is_expected.to be_blank }
      end

      context 'when discount_type is MouseKeyboardDiscounter' do
        let(:discount_type) { 'MouseKeyboardDiscounter' }

        it { is_expected.to be_blank }
      end

      context 'when discount_type is TenWhiteDiscounter' do
        let(:discount_type) { 'TenWhiteDiscounter' }

        it { is_expected.to be_blank }
      end

      context 'when discount_type is blank' do
        let(:discount_type) { '' }

        it { is_expected.to be_present }
      end

      context 'when discount_type is invalid' do
        let(:discount_type) { 'invalid' }

        it { is_expected.to be_present }
      end
    end
  end
end
