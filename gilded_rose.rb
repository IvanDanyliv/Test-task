class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class GildedRose
  def initialize(items)
    @items = items.map { |item| ItemFactory.create(item) }
  end

  def update_quality
    @items.each(&:update_quality)
  end
end

class ItemFactory
  def self.create(item)
    case item.name
    when 'Aged Brie' then AgedBrie.new(item)
    when 'Backstage passes' then BackstagePasses.new(item)
    when 'Conjured' then ConjuredItem.new(item)
    when 'Sulfuras' then Sulfuras.new(item)
    else NormalItem.new(item)
    end
  end
end

class BaseItem
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    update_sell_in
    update_quality_value
  end

  protected

  def decrease_quality(amount = 1)
    item.quality = [item.quality - amount, MIN_QUALITY].max
  end

  def increase_quality(amount = 1)
    item.quality = [item.quality + amount, MAX_QUALITY].min
  end

  def update_sell_in
    item.sell_in -= 1
  end

  def expired?
    item.sell_in < 0
  end
end

class NormalItem < BaseItem
  def update_quality_value
    decrease_quality(expired? ? 2 : 1)
  end
end

class AgedBrie < BaseItem
  def update_quality_value
    increase_quality(expired? ? 2 : 1)
  end
end

class BackstagePasses < BaseItem
  def update_quality_value
    if expired?
      item.quality = 0
    elsif item.sell_in < 5
      increase_quality(3)
    elsif item.sell_in < 10
      increase_quality(2)
    else
      increase_quality(1)
    end
  end
end

class ConjuredItem < BaseItem
  def update_quality_value
    decrease_quality(expired? ? 4 : 2)
  end
end

class Sulfuras < BaseItem
  def update_quality
    # Легендарний предмет, не змінюється
  end
end
