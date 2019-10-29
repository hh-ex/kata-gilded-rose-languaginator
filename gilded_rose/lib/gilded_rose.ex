defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def decrease_quality(item, n) do
    %{item | quality: item.quality - n}
  end

  def increase_quality(item, n) do
    %{item | quality: min(item.quality + n, 50)}
  end

  def decrease_sell_in(item, n) do
    %{item | sell_in: item.sell_in - n}
  end

  def update_item(item) do
    item =
      cond do
        item.name == "Conjured Item" ->
          if item.quality > 0 do
            decrease_quality(item, 2)
          else
            item
          end

        item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
          if item.quality > 0 do
            if item.name != "Sulfuras, Hand of Ragnaros" do
              decrease_quality(item, 1)
            else
              item
            end
          else
            item
          end

        true ->
          cond do
            item.quality < 50 ->
              item = increase_quality(item, 1)

              cond do
                item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                  item =
                    cond do
                      item.sell_in < 11 ->
                        cond do
                          item.quality < 50 ->
                            increase_quality(item, 1)

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
                          increase_quality(item, 1)

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
          decrease_sell_in(item, 1)

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
                        decrease_quality(item, 1)

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
                increase_quality(item, 1)

              true ->
                item
            end
        end

      true ->
        item
    end
  end
end
