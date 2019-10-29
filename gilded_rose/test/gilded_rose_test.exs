defmodule GildedRoseTest do
  use ExUnit.Case
  doctest GildedRose

  def test_update(name, %{q: [q1, q2], s: [s1, s2]}) do
    assert GildedRose.update_quality([%Item{name: name, quality: q1, sell_in: s1}]) == [
             %Item{name: name, quality: q2, sell_in: s2}
           ]
  end

  describe "update_quality" do
    test "some item" do
      test_update("Some Item", %{q: [50, 49], s: [9, 8]})
      test_update("Some Item", %{q: [11, 10], s: [11, 10]})
      test_update("Some Item", %{q: [10, 9], s: [10, 9]})
      test_update("Some Item", %{q: [10, 9], s: [9, 8]})
      test_update("Some Item", %{q: [10, 9], s: [7, 6]})
      test_update("Some Item", %{q: [10, 9], s: [6, 5]})
      test_update("Some Item", %{q: [10, 9], s: [5, 4]})
      test_update("Some Item", %{q: [10, 9], s: [4, 3]})
      test_update("Some Item", %{q: [10, 9], s: [3, 2]})
      test_update("Some Item", %{q: [10, 9], s: [2, 1]})
      test_update("Some Item", %{q: [10, 9], s: [1, 0]})
      test_update("Some Item", %{q: [10, 8], s: [0, -1]})
      test_update("Some Item", %{q: [10, 8], s: [-6, -7]})
    end

    test "Backstage passes" do
      name = "Backstage passes to a TAFKAL80ETC concert"
      test_update(name, %{q: [50, 50], s: [9, 8]})
      test_update(name, %{q: [11, 12], s: [11, 10]})
      test_update(name, %{q: [10, 12], s: [10, 9]})
      test_update(name, %{q: [10, 12], s: [9, 8]})
      test_update(name, %{q: [10, 12], s: [7, 6]})
      test_update(name, %{q: [10, 12], s: [6, 5]})
      test_update(name, %{q: [10, 13], s: [5, 4]})
      test_update(name, %{q: [10, 13], s: [4, 3]})
      test_update(name, %{q: [10, 13], s: [3, 2]})
      test_update(name, %{q: [10, 13], s: [2, 1]})
      test_update(name, %{q: [10, 13], s: [1, 0]})
      test_update(name, %{q: [10, 0], s: [0, -1]})
      test_update(name, %{q: [10, 0], s: [-6, -7]})
    end

    test "Sulfuras" do
      name = "Sulfuras, Hand of Ragnaros"
      test_update(name, %{q: [50, 50], s: [9, 9]})
      test_update(name, %{q: [11, 11], s: [11, 11]})
      test_update(name, %{q: [10, 10], s: [10, 10]})
      test_update(name, %{q: [10, 10], s: [9, 9]})
      test_update(name, %{q: [10, 10], s: [7, 7]})
      test_update(name, %{q: [10, 10], s: [6, 6]})
      test_update(name, %{q: [10, 10], s: [5, 5]})
      test_update(name, %{q: [10, 10], s: [4, 4]})
      test_update(name, %{q: [10, 10], s: [3, 3]})
      test_update(name, %{q: [10, 10], s: [2, 2]})
      test_update(name, %{q: [10, 10], s: [1, 1]})
      test_update(name, %{q: [10, 10], s: [0, 0]})
      test_update(name, %{q: [10, 10], s: [-6, -6]})
    end

    test "Aged Brie" do
      name = "Aged Brie"
      test_update(name, %{q: [50, 50], s: [9, 8]})
      test_update(name, %{q: [11, 12], s: [11, 10]})
      test_update(name, %{q: [10, 11], s: [10, 9]})
      test_update(name, %{q: [10, 11], s: [9, 8]})
      test_update(name, %{q: [10, 11], s: [7, 6]})
      test_update(name, %{q: [10, 11], s: [6, 5]})
      test_update(name, %{q: [10, 11], s: [5, 4]})
      test_update(name, %{q: [10, 11], s: [4, 3]})
      test_update(name, %{q: [10, 11], s: [3, 2]})
      test_update(name, %{q: [10, 11], s: [2, 1]})
      test_update(name, %{q: [10, 11], s: [1, 0]})
      test_update(name, %{q: [10, 12], s: [0, -1]})
      test_update(name, %{q: [10, 12], s: [-6, -7]})
    end

    test "some conjured item" do
      test_update("Conjured Item", %{q: [50, 48], s: [9, 8]})
      test_update("Conjured Item", %{q: [11, 9], s: [11, 10]})
      test_update("Conjured Item", %{q: [10, 8], s: [10, 9]})
      test_update("Conjured Item", %{q: [10, 8], s: [9, 8]})
      test_update("Conjured Item", %{q: [10, 8], s: [7, 6]})
      test_update("Conjured Item", %{q: [10, 8], s: [6, 5]})
      test_update("Conjured Item", %{q: [10, 8], s: [5, 4]})
      test_update("Conjured Item", %{q: [10, 8], s: [4, 3]})
      test_update("Conjured Item", %{q: [10, 8], s: [3, 2]})
      test_update("Conjured Item", %{q: [10, 8], s: [2, 1]})
      test_update("Conjured Item", %{q: [10, 8], s: [1, 0]})
      test_update("Conjured Item", %{q: [10, 6], s: [0, -1]})
      test_update("Conjured Item", %{q: [10, 6], s: [-6, -7]})
      test_update("Conjured Item", %{q: [1, 0], s: [0, -1]})
    end
  end
end
