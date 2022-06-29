RSpec.describe FixedPricePromoCalculation do
  let(:price) { 3 }
  let(:criteria) { OpenStruct.new(quantity: 2) }
  let(:sku) { Sku.new('A', 5) }
  let(:item) { CartItem.new(sku, 3, sku.price) }

  subject { described_class.new(price, criteria) }

  describe 'When the calculation is 2 for 3 dollars' do
    describe 'and there are three items' do
      it 'combines the promo and item price' do
        priced_item = subject.call(item)
        expect(priced_item.price).to eq(8)
      end
    end
  end
end
