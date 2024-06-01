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
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.sell_in -= 1 unless item.name == 'Sulfuras'
      case item.name
      when 'Aged Brie'
        update_aged_brie(item)
      when 'Backstage passes'
        update_backstage_passes(item)
      when 'Conjured'
        update_conjured_item(item)
      when 'Sulfuras'
        # Sulfuras не потребує оновлення
      else
        update_normal_item(item)
      end
    end
  end

  private

  def update_aged_brie(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in < 0
  end

  def update_backstage_passes(item)
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in < 5
      increase_quality(item, 3)
    elsif item.sell_in < 10
      increase_quality(item, 2)
    else
      increase_quality(item)
    end
  end

  def update_conjured_item(item)
    decrease_quality(item, 2)
    decrease_quality(item, 2) if item.sell_in < 0
  end

  def update_normal_item(item)
    decrease_quality(item)
    decrease_quality(item) if item.sell_in < 0
  end

  def increase_quality(item, amount = 1)
    item.quality += amount if item.quality < 50
  end

  def decrease_quality(item, amount = 1)
    item.quality -= amount if item.quality > 0
  end
end
