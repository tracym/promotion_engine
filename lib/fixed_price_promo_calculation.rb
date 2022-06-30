class FixedPricePromoCalculation
  attr_reader :price, :criteria

  def initialize(price, criteria)
    @price = price
    @criteria = criteria
  end

  def call(item)
    left = (item.quantity % criteria.quantity)
    item.price = ((item.quantity / criteria.quantity) * price) +
                 (left * item.sku.price)
    item
  end
end
