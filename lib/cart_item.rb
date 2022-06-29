class CartItem
  attr_reader :sku
  attr_accessor :quantity, :price, :promo

  def initialize(sku, quantity, price = 0)
    @sku = sku
    @quantity = quantity
    @price = price
    @promo = nil
  end

  def id
    sku.id
  end
end
