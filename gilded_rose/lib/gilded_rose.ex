defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item = cond do
      item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
        # default item
        change_quality(item, -1)
      true ->
        cond do
          item.quality < 50 ->
            item = change_quality(item, +1)
            cond do
              item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                item = cond do
                  item.sell_in < 11 ->
                        change_quality(item, 1)
                  true -> item
                end
                cond do
                  item.sell_in < 6 ->
                        change_quality(item, 1)
                  true -> item
                end
              true -> item
            end
          true -> item
        end
    end
    item = change_sell_in(item, -1)
    cond do
      item.sell_in < 0 ->
        cond do
          item.name != "Aged Brie" ->
            cond do
              item.name != "Backstage passes to a TAFKAL80ETC concert" ->
                    change_quality(item, -1)
              true -> change_quality(item, -item.quality)
            end
          true ->
                change_quality(item, 1)
        end
      true -> item
    end
  end

  defp change_sell_in(%Item{name: "Sulfuras, Hand of Ragnaros"} = item, _amount), do: item
  defp change_sell_in(%Item{sell_in: sell_in} = item, amount) do
    %Item{item | sell_in: sell_in + amount}
  end

  defp change_quality(%Item{name: "Sulfuras, Hand of Ragnaros"} = item, _amount), do: item
  defp change_quality(%Item{quality: quality} = item, amount) do
    quality =
      quality
      |> Kernel.+(amount)
      |> max(0)
      |> min(50)

    %Item{item | quality: quality}
  end


end
