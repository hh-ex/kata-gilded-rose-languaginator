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

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: "Conjured Item"} = item), do: update_conjured_item(item)

  defp update_conjured_item(item) do
    item |> update_quality(-2) |> update_sell_in
  end

  defp update_quality(%Item{sell_in: sell_in} = item, n) when sell_in > 0 do
    %{item | quality: item.quality + n |> min(50) |> max(0)}
  end

  defp update_quality(item, n) do
    %{item | quality: item.quality + 2*n |> min(50) |> max(0)}
  end

  def update_item(item) do
    item = cond do
      item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
        if item.quality > 0 do
          if item.name != "Sulfuras, Hand of Ragnaros" do
            if item.name == "Conjured Item" do
              %{item | quality: max(0, item.quality - 2)}
            else
              %{item | quality: item.quality - 1}
            end
          else
            item
          end
        else
          item
        end
      true ->
        cond do
          item.quality < 50 ->
            item = %{item | quality: item.quality + 1}
            cond do
              item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                item = cond do
                  item.sell_in < 11 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
                cond do
                  item.sell_in < 6 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
              true -> item
            end
          true -> item
        end
    end
    item = cond do
      item.name != "Sulfuras, Hand of Ragnaros" ->
        %{item | sell_in: item.sell_in - 1}
      true -> item
    end
    cond do
      item.sell_in < 0 ->
        cond do
          item.name != "Aged Brie" ->
            cond do
              item.name != "Backstage passes to a TAFKAL80ETC concert" ->
                cond do
                  item.quality > 0 ->
                    cond do
                      item.name != "Sulfuras, Hand of Ragnaros" ->
                        if item.name == "Conjured Item" do
                          %{item | quality: max(0, item.quality - 2)}
                        else
                          %{item | quality: item.quality - 1}
                        end
                      true -> item
                    end
                  true -> item
                end
              true -> %{item | quality: item.quality - item.quality}
            end
          true ->
            cond do
              item.quality < 50 ->
                %{item | quality: item.quality + 1}
              true -> item
            end
        end
      true -> item
    end
  end
end
