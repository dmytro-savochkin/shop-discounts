# frozen_string_literal: true

describe Orders::ApplyDiscountsService do
  describe '#call' do
    subject { service.call }

    let(:service) do
      described_class.new(discounter_getter: discounter_getter,
                          order: order,
                          customer: customer)
    end
    let(:order) { create :order, total: 1000 }
    let(:customer) { create :customer }

    context 'with no discounters' do
      let(:discounter_getter) { double(call: []) }

      it 'does not change order total' do
        expect { subject }.not_to change { order.reload.total }
      end

      it 'does not create order_discounts' do
        expect { subject }.not_to change { OrderDiscount.count }
      end
    end

    # TODO: this can be rewritten a bit to have less doubles but I don't have time
    context 'with single discounter' do
      let(:discounter_getter) do
        double(call: [Orders::Discounters::LateFoodDiscounter])
      end
      let(:discounter) { double(applicable?: true, discount: Money.new('100')) }

      before do
        allow(Discounters::LateFoodDiscounter).to receive(:new).and_return(discounter)
      end

      it 'sets order total to 900' do
        expect { subject }.to change { order.reload.total }.to Money.new('900')
      end

      it 'creates order_discount' do
        expect { subject }.to change { OrderDiscount.count }.by 1
      end
    end

    context 'with two discounters' do
      # TODO: Implement.
    end
  end
end
