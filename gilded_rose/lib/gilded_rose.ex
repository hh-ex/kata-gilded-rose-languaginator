defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item
    |> change_quality()
    |> change_sell_in()
  end

  def update_item(%{name: "Conjured Item"} = item) do
    item
    |> change_quality()
    |> change_sell_in()
  end

  defp change_quality(%{name: "Conjured Item", quality: quality, sell_in: sell_in} = item)
       when sell_in <= 0 do
    decrease_quality(item, 4)
  end

  defp change_quality(%{name: "Conjured Item", quality: quality, sell_in: sell_in} = item) do
    decrease_quality(item, 2)
  end

  defp change_quality(
         %{name: "Backstage passes to a TAFKAL80ETC concert", quality: quality, sell_in: sell_in} =
           item
       ) do
    cond do
      item.sell_in > 10 ->
        increase_quality(item, 1)

      item.sell_in > 5 ->
        increase_quality(item, 2)

      item.sell_in > 0 ->
        increase_quality(item, 3)

      true ->
        decrease_quality(item, quality)
    end
  end

  defp decrease_quality(item, n) do
    %{item | quality: max(item.quality - n, 0)}
  end

  defp increase_quality(item, n) do
    %{item | quality: min(item.quality + n, 50)}
  end

  defp change_sell_in(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  def update_item(item) do
    item =
      cond do
        item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
          if item.quality > 0 do
            if item.name != "Sulfuras, Hand of Ragnaros" do
              %{item | quality: item.quality - 1}
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
                  item =
                    cond do
                      item.sell_in < 11 ->
                        cond do
                          item.quality < 50 ->
                            %{item | quality: item.quality + 1}

                          true ->
                            item
                        end

                      true ->
                        item
                    end

                  cond do
                    item.sell_in < 6 ->
                      cond do
                        item.quality < 50 ->
                          %{item | quality: item.quality + 1}

                        true ->
                          item
                      end

                    true ->
                      item
                  end

                true ->
                  item
              end

            true ->
              item
          end
      end

    item =
      cond do
        item.name != "Sulfuras, Hand of Ragnaros" ->
          %{item | sell_in: item.sell_in - 1}

        true ->
          item
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
                        %{item | quality: item.quality - 1}

                      true ->
                        item
                    end

                  true ->
                    item
                end

              true ->
                %{item | quality: item.quality - item.quality}
            end

          true ->
            cond do
              item.quality < 50 ->
                %{item | quality: item.quality + 1}

              true ->
                item
            end
        end

      true ->
        item
    end
  end
end
