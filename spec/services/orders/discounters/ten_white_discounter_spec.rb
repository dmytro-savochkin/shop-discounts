# frozen_string_literal: true

describe Orders::Discounters::TenWhiteDiscounter do
  let(:discounter) { described_class.new(order: order) }
  let(:order) { create :order }

  shared_context 'when white items ordered' do |count|
    before { create_list :order_item, count, :white, order: order }
  end

  shared_context 'when black items ordered' do |count|
    before { create_list :order_item, count, :black, order: order }
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

    context 'when 1 white item ordered' do
      include_context 'when white items ordered', 1

      it { is_expected.to be_falsey }
    end

    context 'when 9 white items ordered' do
      include_context 'when white items ordered', 9

      it { is_expected.to be_falsey }
    end

    context 'when 10 white items ordered' do
      include_context 'when white items ordered', 10

      it { is_expected.to be_truthy }
    end

    context 'when 11 white items ordered' do
      include_context 'when white items ordered', 11

      it { is_expected.to be_truthy }
    end

    context 'when 10 black items ordered' do
      include_context 'when black items ordered', 10

      it { is_expected.to be_falsey }
    end

    context 'when 9 white and 10 black items ordered' do
      include_context 'when white items ordered', 9
      include_context 'when black items ordered', 10

      it { is_expected.to be_falsey }
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
