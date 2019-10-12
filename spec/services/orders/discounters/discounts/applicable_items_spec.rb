# frozen_string_literal: true

describe Orders::Discounters::Discounts::ApplicableItems do
  describe '#call' do
    subject { described_class.call(items: items, discount_value: discount_value) }

    shared_examples 'ArgumentError' do
      it 'raises ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end

    context 'when items and discount_value are passed' do
      context 'when items are empty' do
        let(:items) { [] }

        it 'returns 0' do
          is_expected.to eq 0
        end
      end

      context 'when items are not empty' do
        context 'when there is one item' do
          let(:items) do
            [build(:order_item, price: 100)]
          end

          context 'when discount_value is 5' do
            let(:discount_value) { 5 }

            it 'returns 5' do
              is_expected.to eq 5
            end
          end

          context 'when discount_value is 50' do
            let(:discount_value) { 50 }

            it 'returns 50' do
              is_expected.to eq 50
            end
          end

          context 'when discount_value is 100' do
            it 'returns 100'
          end

          context 'when discount_value is 0' do
            it 'returns 0'
          end

          context 'when discount_value is -1' do
            it 'raises ArgumentError'
          end

          context 'when discount_value is 1000' do
            it 'raises ArgumentError'
          end
        end

        context 'when there are two items' do
          context 'when discount_value is -1'
          context 'when discount_value is 0'
          context 'when discount_value is 5'
          context 'when discount_value is 50'
          context 'when discount_value is 100'
          context 'when discount_value is 1000'
        end
      end
    end

    context 'when items are not passed' do
      let(:items) { nil }
      let(:discount_value) { 5 }

      include_examples 'ArgumentError'
    end

    context 'when discount_value is not passed' do
      let(:items) { [] }
      let(:discount_value) { nil }

      include_examples 'ArgumentError'
    end
  end
end
