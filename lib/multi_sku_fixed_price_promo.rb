class MultiSkuFixedPricePromo < NItemsFixedPricePromo
  def eligible
    items.select do |item|
      criteria.sku_ids.include?(item.id) && all_items_included?
    end
  end

  def all_items_included?
    skus = items.select { |item| criteria.sku_ids.include? item.id }
    skus.count.eql? criteria.sku_ids.count
  end
end
