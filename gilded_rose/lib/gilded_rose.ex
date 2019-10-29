defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  # item.name
  # item.quality
  # item.sell_in

  # quality
  # - incr
  # - decr

  # quality
  # - clip: min: 0, max: 50
  
  defp update_sell_in(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  defp update_brie(item) do
    item |> update_quality(1) |> update_sell_in()
  end

  defp update_backstage_pass(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    item |> update_quality(-item.quality) |> update_sell_in()
  end

  defp update_backstage_pass(%Item{sell_in: sell_in} = item) when sell_in > 10 do
    item |> update_quality(1) |> update_sell_in()
  end

  defp update_backstage_pass(%Item{sell_in: sell_in} = item) when sell_in <= 5 do
    item |> update_quality(3) |> update_sell_in()
  end

  defp update_backstage_pass(%Item{sell_in: sell_in} = item) when sell_in <= 10 do
    item |> update_quality(2) |> update_sell_in()
  end

  defp update_conjured_item(item) do
    item |> update_quality(-2) |> update_sell_in
  end

  defp update_quality(%Item{sell_in: sell_in} = item, n) when sell_in > 0 do
    %{item | quality: item.quality + n |> min(50) |> max(0)}
  end

  defp update_quality(item, n) do
    %{item | quality: item.quality + 2*n |> min(50) |> max(0)}
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    update_backstage_pass(item)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    update_brie(item)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: "Conjured Item"} = item), do: update_conjured_item(item)

def update_item(item) do
  item |> update_quality(-1) |> update_sell_in()
end
end
