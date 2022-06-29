RSpec.describe CartItem do
  let(:sku) { Sku.new('A', 1) }
  let(:quantity) { 2 }

  subject { described_class.new(sku, quantity) }

  describe 'initialization' do
    it 'sets the sku' do
      expect(subject.sku).to eq(sku)
    end

    it 'sets the quantity' do
      expect(subject.quantity).to eq(quantity)
    end

    it 'defaults the promo' do
      expect(subject.promo).to be_nil
    end

    it 'defaults the price' do
      expect(subject.price).to eq(0)
    end
  end

  it 'responds to id' do
    expect(subject.id).to eq(sku.id)
  end
end
