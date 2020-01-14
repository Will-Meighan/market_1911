class Vendor

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    if !@inventory.include?(item)
      0
    else
      (@inventory.find { |item_type| item = item_type }).last
    end
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

end
