# frozen_string_literal: true

describe Orders::Discounters::MouseKeyboardDiscounter do
  let(:discounter) { described_class.new(order: order) }
  let(:order) { create :order }

  shared_context 'when mouse ordered' do
    before { create :order_item, :mouse, order: order }
  end

  shared_context 'when keyboard ordered' do
    before { create :order_item, :keyboard, order: order }
  end

  shared_context 'when food ordered' do
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

    context 'when nothing is ordered' do
      it { is_expected.to be_falsey }
    end

    context 'when food ordered' do
      include_context 'when food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when mouse and food are ordered' do
      include_context 'when mouse ordered'
      include_context 'when food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when keyboard and food are ordered' do
      include_context 'when keyboard ordered'
      include_context 'when food ordered'

      it { is_expected.to be_falsey }
    end

    context 'when mouse and keyboard are ordered' do
      include_context 'when mouse ordered'
      include_context 'when keyboard ordered'

      it { is_expected.to be_truthy }
    end
  end

  describe '#discount' do
    subject { discounter.discount }

    let(:discount_double) do
      instance_double(Orders::Discounters::Discounts::ApplicableItems, call: 5)
    end

    after { subject }

    it 'calls Discounts::ApplicableItems' do
      allow(Discounts::ApplicableItems).to receive(:new).and_return(discount_double)
      expect(discount_double)
        .to receive(:call).with(items: items, discount_value: BigDecimal('5.0'))
    end
  end
end
