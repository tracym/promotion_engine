class Cart
  attr_accessor :items, :promotions

  def initialize(items = [], promotions = [])
    @items = items
    @promotions = promotions
    @promotions.each do |promo|
      promo.items = items
    end
  end

  def checkout!
    promotions.each(&:apply)
    items.select { |item| item.promo.nil? }.each do |item|
      item.price = item.sku.price
    end
  end

  def total
    items.map(&:price).sum
  end
end
