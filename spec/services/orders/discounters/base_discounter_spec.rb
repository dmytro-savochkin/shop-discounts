
describe Orders::Discounters::BaseDiscounter do
  shared_examples 'NotImplementedError' do
    it 'raises NotImplementedError' do
      expect { subject }.to raise_error NotImplementedError
    end
  end

  let(:base_discounter) do
    described_class.new(order: order, customer: customer)
  end
  let(:order) { build :order }
  let(:customer) { build :customer }

  describe '#applicable?' do
    subject { base_discounter.applicable? }

    include_examples 'NotImplementedError'
  end

  describe '#discount' do
    subject { base_discounter.discount }

    include_examples 'NotImplementedError'
  end
end
