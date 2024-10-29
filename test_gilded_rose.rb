require 'minitest/autorun'
require_relative 'gilded_rose'

class TestGildedRose < Minitest::Test
  def setup
    @items = [
      Item.new("Aged Brie", 2, 0),
      Item.new("Elixir", 5, 7),
      Item.new("Sulfuras", 0, 80),
      Item.new("Backstage passes", 15, 20),
      Item.new("Conjured", 3, 6)
    ]
    @gilded_rose = GildedRose.new(@items)
  end

  def test_aged_brie
    @gilded_rose.update_quality()
    assert_equal 1, @items[0].quality
    assert_equal 1, @items[0].sell_in
  end

  def test_backstage_passes
    item = Item.new("Backstage passes", 5, 45)
    gilded_rose = GildedRose.new([item])

    gilded_rose.update_quality()
    assert_equal 48, item.quality
    assert_equal 4, item.sell_in

    item.sell_in = 0
    gilded_rose.update_quality()
    assert_equal 0, item.quality
  end

  def test_sulfuras
    @gilded_rose.update_quality()
    assert_equal 80, @items[2].quality
    assert_equal 0, @items[2].sell_in
  end

  def test_conjured_items
    item = Item.new("Conjured", 3, 6)
    gilded_rose = GildedRose.new([item])

    gilded_rose.update_quality()
    assert_equal 4, item.quality

    gilded_rose.update_quality()
    assert_equal 2, item.quality

    gilded_rose.update_quality()
    assert_equal 0, item.quality
  end

  def test_quality_never_exceeds_50
    item = Item.new("Aged Brie", 10, 49)
    gilded_rose = GildedRose.new([item])

    gilded_rose.update_quality()
    assert_equal 50, item.quality
  end

  def test_normal_item_quality_never_negative
    item = Item.new("Normal Item", 5, 0)
    gilded_rose = GildedRose.new([item])

    3.times { gilded_rose.update_quality() }
    assert_equal 0, item.quality
  end
end
