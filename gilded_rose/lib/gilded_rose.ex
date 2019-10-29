defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: "Aged Brie"} = item) do
    %{item | sell_in: item.sell_in - 1, quality: min(50, item.quality + 1)}
  end

  def update_item(%{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    update_backstage_pass(item)
  end

  def update_item(%{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
  end

  def update_item(%{name: "Conjured" <> _} = item) do
    update_item_default(item, 2)
  end

  def update_item(item) do
    update_item_default(item, 1)
  end

  def update_item_default(%{sell_in: sell_in} = item, multi) when sell_in <= 0 do
    %{item | quality: max(0, item.quality - 2 * multi), sell_in: item.sell_in - 1}
  end

  def update_item_default(item, multi) do
    %{item | quality: max(0, item.quality - 1 * multi), sell_in: item.sell_in - 1}
  end

  def update_backstage_pass(%{sell_in: sell_in} = item) when sell_in <= 0 do
    %{item | quality: 0, sell_in: sell_in - 1}
  end

  def update_backstage_pass(%{sell_in: sell_in} = item) when sell_in <= 5 do
    %{item | quality: min(50, item.quality + 3), sell_in: sell_in - 1}
  end

  def update_backstage_pass(%{sell_in: sell_in} = item) when sell_in <= 10 do
    %{item | quality: min(50, item.quality + 2), sell_in: sell_in - 1}
  end

  def update_backstage_pass(item) do
    %{item | quality: min(50, item.quality + 1), sell_in: item.sell_in - 1}
  end
end
