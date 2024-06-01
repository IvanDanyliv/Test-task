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
    @gilded_rose.update_quality()
    assert_equal 21, @items[3].quality
    assert_equal 14, @items[3].sell_in

    @items[3].sell_in = 10
    @gilded_rose.update_quality()
    assert_equal 23, @items[3].quality
    assert_equal 9, @items[3].sell_in

    @items[3].sell_in = 5
    @gilded_rose.update_quality()
    assert_equal 26, @items[3].quality
    assert_equal 4, @items[3].sell_in

    @items[3].sell_in = 0
    @gilded_rose.update_quality()
    assert_equal 0, @items[3].quality
    assert_equal -1, @items[3].sell_in
  end

  def test_sulfuras
    @gilded_rose.update_quality()
    assert_equal 80, @items[2].quality
    assert_equal 0, @items[2].sell_in

    @items[2].sell_in = -1
    @gilded_rose.update_quality()
    assert_equal 80, @items[2].quality
    assert_equal -1, @items[2].sell_in
  end

  def test_conjured_items
    @gilded_rose.update_quality()
    assert_equal 4, @items[4].quality
    assert_equal 2, @items[4].sell_in

    @gilded_rose.update_quality()
    assert_equal 2, @items[4].quality
    assert_equal 1, @items[4].sell_in

    @gilded_rose.update_quality()
    assert_equal 0, @items[4].quality
    assert_equal 0, @items[4].sell_in

    @gilded_rose.update_quality()
    assert_equal 0, @items[4].quality
    assert_equal -1, @items[4].sell_in
  end
end
