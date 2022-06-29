RSpec.describe Sku do
  let(:identifier) { 'A' }
  let(:price) { 1 }
  subject { described_class.new(identifier, price) }

  it 'can be identified' do
    expect(subject.id).to eq(identifier)
  end

  it 'can be priced' do
    expect(subject.price).to eq(price)
  end
end
