# frozen_string_literal: true

describe Orders::Discounters::LateFoodDiscounter do
  let(:discounter) { described_class.new(order: order) }
  let(:order) { create :order }

  shared_context 'when early hour' do
    before { travel_to Time.zone.parse('10:00:00') }
  end

  shared_context 'when late hour' do
    before { travel_to Time.zone.parse('21:00:00') }
  end

  shared_context 'when no food ordered' do
    let(:order) { create :order }

    before { create :order_item, :computer_part, order: order }
  end

  shared_context 'when food ordered' do
    let(:order) { create :order }

    before { create :order_item, :food, order: order }
  end

  describe '.new' do
    subject { discounter }

    context 'when order is an Order' do
      let(:order) { build :order }

      it { expect { subject }.not_to raise_error }
    end

    context 'when order is not an Order' do
      let(:order) { nil }

      it { expect { subject }.to raise_error ArgumentError }
    end
  end

  describe '#applicable?' do
    subject { discounter.applicable? }

    context 'when early hour and no food ordered' do
      include_context 'when early hour'
      include_context 'when no food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when late hour and no food ordered' do
      include_context 'when late hour'
      include_context 'when no food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when early hour and food ordered' do
      include_context 'when early hour'
      include_context 'when food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when late hour and food ordered' do
      include_context 'when late hour'
      include_context 'when food ordered'

      it { is_expected.to be_truthy }
    end
  end

  describe '#discount' do
    subject { discounter.discount }

    let(:discount_double) do
      instance_double(Orders::Discounters::Discounts::ApplicableItems, call: 5)
    end

    include_context 'when late hour'
    include_context 'when food ordered'

    after { subject }

    it 'calls Discounts::ApplicableItems' do
      allow(Discounts::ApplicableItems).to receive(:new).and_return(discount_double)
      expect(discount_double)
        .to receive(:call).with(items: items, discount_value: BigDecimal('5.0'))
    end
  end
end
