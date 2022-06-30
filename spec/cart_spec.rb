RSpec.describe Cart do
  let(:skus) do
    [Sku.new('A', 50),
     Sku.new('B', 30),
     Sku.new('C', 20),
     Sku.new('D', 15)]
  end

  let(:a3_criteria) { OpenStruct.new(quantity: 3, sku_id: 'A') }
  let(:a3_calc) { FixedPricePromoCalculation.new(130, a3_criteria) }
  let(:a3_promo) { NItemsFixedPricePromo.new("3 of A's for 130", a3_criteria, a3_calc) }

  let(:b2_criteria) { OpenStruct.new(quantity: 2, sku_id: 'B') }
  let(:b2_calc) { FixedPricePromoCalculation.new(45, b2_criteria) }
  let(:b2_promo) { NItemsFixedPricePromo.new("2 of B's for 45", b2_criteria, b2_calc) }

  let(:cd30_criteria) { OpenStruct.new(sku_ids: %w(C D)) }
  let(:cd30_calc) { MultiSkuPromoCalculation.new(30, cd30_criteria) }
  let(:cd30_promo) { MultiSkuFixedPricePromo.new('C & D for 30', cd30_criteria, cd30_calc) }

  before do
    cd30_calc.apply_promo_to_sku = 'D'
  end

  let(:promotions) { [a3_promo, b2_promo, cd30_promo] }

  describe 'Scenario A' do
    let(:items) do
      [CartItem.new(skus[0], 1),
       CartItem.new(skus[1], 1),
       CartItem.new(skus[2], 1)]
    end

    describe 'The cart total' do
      subject { described_class.new(items, promotions) }

      it 'is 100' do
        subject.checkout!
        expect(subject.total).to eq(100)
      end
    end
  end

  describe 'Scenario B' do
    let(:items) do
      [CartItem.new(skus[0], 5),
       CartItem.new(skus[1], 5),
       CartItem.new(skus[2], 1)]
    end

    describe 'The cart total' do
      subject { described_class.new(items, promotions) }

      it 'is 370' do
        subject.checkout!
        expect(subject.total).to eq(370)
      end
    end
  end

  describe 'Scenario C' do
    let(:items) do
      [CartItem.new(skus[0], 3),
       CartItem.new(skus[1], 5),
       CartItem.new(skus[2], 1),
       CartItem.new(skus[3], 1)]
    end

    describe 'The cart total' do
      subject { described_class.new(items, promotions) }

      it 'is 280' do
        subject.checkout!
        expect(subject.total).to eq(280)
      end
    end
  end
end
