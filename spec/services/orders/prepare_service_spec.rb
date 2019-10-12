# frozen_string_literal: true

describe Orders::PrepareService do
  describe '#call' do
    subject { service.call }

    let(:service) do
      described_class.new(customer: customer,
                          product: product,
                          discounts_applier: discounts_applier)
    end
    let(:product) { create :product }
    let(:customer) { create :customer }
    let(:discounts_applier) { double }

    shared_examples 'new order' do
      it 'creates an order' do
        expect { subject }.to change { customer.orders.count }.from(0).to 1
      end
    end

    shared_examples 'no new order' do
      it 'does not create an order' do
        expect { subject }.not_to change { customer.orders.count }.from 1
      end
    end

    shared_examples 'new product' do
      it 'adds product to the created order' do
        subject
        expect(customer.orders.first.order_items.first.product).to eq product
      end
    end

    shared_examples 'discounts_applier call' do
      it 'calls discounts_applier' do
        expect(discounts_applier).to receive(:call)
        subject
      end
    end

    context 'when there is no order' do
      include_examples 'new order'
      include_examples 'new product'
      include_examples 'discounts_applier call'
    end

    context 'when there is an order' do
      before { create :order, customer: customer }

      include_examples 'no new order'
      include_examples 'new product'
      include_examples 'discounts_applier call'
    end
  end
end
