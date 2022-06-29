RSpec.describe NItemsFixedPricePromo do
  let(:price) { 3 }
  let(:criteria) { OpenStruct.new(quantity: 2, sku_id: 'A') }
  let(:eligible_sku) { Sku.new('A', 5) }
  let(:other_sku) { Sku.new('B', 2) }

  let(:items) do
    [
      CartItem.new(eligible_sku, 3, eligible_sku.price),
      CartItem.new(other_sku, 1, other_sku.price)
    ]
  end

  let(:name) { "2 A's for 3" }
  let(:calc) { FixedPricePromoCalculation.new(3, criteria) }
  subject { described_class.new(name, criteria, calc, items) }

  describe 'Eligible skus' do
    it 'finds the right number' do
      expect(subject.eligible_ids.count).to eq(1)
    end

    it 'finds the right sku' do
      expect(subject.eligible_ids.first).to eq(eligible_sku.id)
    end
  end

  describe 'Calculating the promo' do
    it 'alters the item price correctly' do
      subject.apply
      correct_item = subject.items.find do |item|
        item.id.eql? eligible_sku.id
      end
      expect(correct_item.price).to eq(8)
    end

    it 'indicates a promo has been applied' do
      subject.apply
      correct_item = subject.items.find do |item|
        item.id.eql? eligible_sku.id
      end
      expect(correct_item.promo).to eq(name)
    end
  end
end
