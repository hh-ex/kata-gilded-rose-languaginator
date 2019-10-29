defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  describe "update_quality" do
    test "some item" do
      assert GildedRose.update_quality([%Item{name: "Some Item", quality: 10, sell_in: 9}]) == [
               %Item{name: "Some Item", quality: 9, sell_in: 8}
             ]

      assert GildedRose.update_quality([%Item{name: "Some Item", quality: 10, sell_in: 1}]) == [
               %Item{name: "Some Item", quality: 9, sell_in: 0}
             ]

      assert GildedRose.update_quality([%Item{name: "Some Item", quality: 10, sell_in: 0}]) == [
               %Item{name: "Some Item", quality: 8, sell_in: -1}
             ]

      assert GildedRose.update_quality([%Item{name: "Some Item", quality: 0, sell_in: 0}]) == [
               %Item{name: "Some Item", quality: 0, sell_in: -1}
             ]
    end

    test "Backstage passes" do
      assert GildedRose.update_quality([
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 1, sell_in: 9}
             ]) == [
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 3, sell_in: 8}
             ]

      assert GildedRose.update_quality([
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 10, sell_in: 4}
             ]) == [
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 13, sell_in: 3}
             ]

      assert GildedRose.update_quality([
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 10, sell_in: 0}
             ]) == [
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 0, sell_in: -1}
             ]

      assert GildedRose.update_quality([
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 50, sell_in: 1}
             ]) == [
               %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 50, sell_in: 0}
             ]
    end

    test "Sulfuras" do
      assert GildedRose.update_quality([
               %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80, sell_in: 9}
             ]) == [
               %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80, sell_in: 9}
             ]
    end

    test "Aged Brie" do
      assert GildedRose.update_quality([
               %Item{name: "Aged Brie", quality: 38, sell_in: 9}
             ]) == [
               %Item{name: "Aged Brie", quality: 39, sell_in: 8}
             ]

      assert GildedRose.update_quality([
               %Item{name: "Aged Brie", quality: 50, sell_in: 9}
             ]) == [
               %Item{name: "Aged Brie", quality: 50, sell_in: 8}
             ]
    end

    test "some conjured item" do
      assert GildedRose.update_quality([
        %Item{name: "Conjured Staff", quality: 48, sell_in: 9}
      ]) == [
        %Item{name: "Conjured Staff", quality: 46, sell_in: 8}
      ]

      assert GildedRose.update_quality([
        %Item{name: "Conjured Staff", quality: 30, sell_in: 0}
      ]) == [
        %Item{name: "Conjured Staff", quality: 26, sell_in: -1}
      ]
    end
  end
end
