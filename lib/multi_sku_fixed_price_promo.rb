class MultiSkuFixedPricePromo < NItemsFixedPricePromo
  def eligible
    items.select do |item|
      criteria.sku_ids.include?(item.id)
    end
  end
end
