require 'minitest/autorun'
require_relative 'gilded_rose'

class GildedRoseTest < Minitest::Test
  def test_aged_brie_increases_in_quality
    items = [Item.new("Aged Brie", 10, 20)]
    GildedRose.new(items).update_quality
    assert_equal 21, items[0].quality
  end

  def test_backstage_passes_increase_in_quality
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)]
    GildedRose.new(items).update_quality
    assert_equal 21, items[0].quality
  end

  def test_backstage_passes_increase_by_2_when_10_days_or_less
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
    GildedRose.new(items).update_quality
    assert_equal 22, items[0].quality
  end

  def test_backstage_passes_increase_by_3_when_5_days_or_less
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
    GildedRose.new(items).update_quality
    assert_equal 23, items[0].quality
  end

  def test_backstage_passes_drop_to_0_after_concert
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
    GildedRose.new(items).update_quality
    assert_equal 0, items[0].quality
  end

  def test_sulfuras_does_not_change
    items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
    GildedRose.new(items).update_quality
    assert_equal 80, items[0].quality
  end

  def test_conjured_items_degrade_twice_as_fast
    items = [Item.new("Conjured Mana Cake", 3, 6)]
    GildedRose.new(items).update_quality
    assert_equal 4, items[0].quality
  end

  def test_conjured_items_degrade_twice_as_fast_after_sell_in
    items = [Item.new("Conjured Mana Cake", 0, 6)]
    GildedRose.new(items).update_quality
    assert_equal 2, items[0].quality
  end
end
