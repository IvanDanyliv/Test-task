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

  def update_quality
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"  # Sulfuras не змінюється

      if item.name == "Aged Brie"
        item.quality += 1 if item.quality < 50
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in > 10
          item.quality += 1
        elsif item.sell_in > 5
          item.quality += 2
        elsif item.sell_in > 0
          item.quality += 3
        else
          item.quality = 0
        end
      elsif item.name.start_with?("Conjured")
        item.quality -= item.sell_in > 0 ? 2 : 4
      else
        item.quality -= item.sell_in > 0 ? 1 : 2
      end

      item.quality = 0 if item.quality < 0
      item.quality = 50 if item.quality > 50

      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
    end
  end
end
