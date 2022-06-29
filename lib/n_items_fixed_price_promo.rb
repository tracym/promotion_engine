class NItemsFixedPricePromo
  attr_reader :name, :criteria, :calculation
  attr_accessor :items

  def initialize(name, criteria, calculation, items = [])
    @name = name
    @criteria = criteria
    @calculation = calculation
    @items = items
  end

  def unpromoted_items
    items.select { |item| item.promo.nil? }
  end
  
  def eligible
    unpromoted_items.select do |item|
      (item.sku.id.eql?(criteria.sku_id) &&
                        item.quantity >= criteria.quantity)
    end
  end

  def eligible_ids
    eligible.map(&:id)
  end

  def apply
    items.map do |item|
      if eligible_ids.include? item.id
        item = calculation.call(item)
        item.promo = name
      end
      item
    end
  end
end
