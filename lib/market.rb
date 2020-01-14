class Market

  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.include?(item) }
  end

  def sorted_item_list
    total_inventory = @vendors.map do |vendor|
      vendor.inventory
    end
    names_array = []
    total_inventory.map do |item|
      item.map do |i|
        names_array << i.first.name
      end
    end
    names_array.uniq.sort
  end

  def total_inventory
    inventory_hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        inventory_hash[item.first] += item.last
      end
    end
    inventory_hash
  end

  def sell(item, quantity)
    checking_item = total_inventory.find { |item_type| item_type = item}
    if checking_item.last < quantity || !total_inventory.include?(item)
      false
    else
      until quantity == 0
      vendor_with_item = @vendors.find do |vendor|
        vendor.inventory.include?(item)
      end
        if quantity <= vendor_with_item.inventory[item]
          vendor_with_item.inventory[item] -= quantity
          quantity = 0
        else
          quantity -= vendor_with_item.inventory[item]
          vendor_with_item.inventory.delete(item)
        end
      end
      true
    end
  end

end
