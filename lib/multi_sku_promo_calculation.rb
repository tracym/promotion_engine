class MultiSkuPromoCalculation < FixedPricePromoCalculation
  attr_accessor :apply_promo_to_sku

  def call(item)
    if item.id.eql? apply_promo_to_sku
      item.price = price
    else
      item.price = 0
    end
    item
  end
end
