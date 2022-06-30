RSpec.describe MultiSkuFixedPricePromo do
  let(:price) { 3 }
  let(:criteria) { OpenStruct.new(sku_ids: %w(A B)) }
  let(:sku) { Sku.new('A', 5) }
  let(:other_sku) { Sku.new('B', 2) }

  let(:items) do
    [
      CartItem.new(sku, 3, sku.price),
      CartItem.new(other_sku, 1, other_sku.price)
    ]
  end

  let(:name) { 'A and B for 3' }
  let(:calc) { MultiSkuPromoCalculation.new(3, criteria) }

  subject { described_class.new(name, criteria, calc, items) }

  describe 'Eligible skus' do
    it 'finds the right number' do
      calc.apply_promo_to_sku = 'A'
      expect(subject.eligible_ids.count).to eq(2)
    end

    it 'finds the right skus' do
      calc.apply_promo_to_sku = 'A'
      expect(subject.eligible_ids).to eq(%w(A B))
    end
  end

  describe 'Application' do
    context 'when apply to sku is set to sku A' do
      it 'applies the promo to sku A' do
        calc.apply_promo_to_sku = 'A'
        subject.apply
        match = subject.items.find { |i| !i.price.eql? 0 }
        expect(match.id).to eq('A')
      end
    end

    context 'when apply to sku is set to sku B' do
      it 'applies the promo to sku B' do
        calc.apply_promo_to_sku = 'B'
        subject.apply
        match = subject.items.find { |i| !i.price.eql? 0 }
        expect(match.id).to eq('B')
      end
    end
  end
end
