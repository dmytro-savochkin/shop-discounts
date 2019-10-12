# frozen_string_literal: true

describe Orders::GetDiscountersService do
  describe '#call' do
    subject { described_class.new.call }

    it 'returns Discounters' do
      is_expected.to contain_exactly Orders::Discounters::LateFoodDiscounter,
                                     Orders::Discounters::MouseKeyboardDiscounter,
                                     Orders::Discounters::TenWhiteDiscounter
    end
  end
end
