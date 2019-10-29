defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def decrease_quality(item, n) do
    %{item | quality: max(0, item.quality - n)}
  end

  def increase_quality(item, n) do
    %{item | quality: min(50, item.quality + n)}
  end

  def update_item(item) do
    item =
      cond do
        item.name == "some conjured item" ->
          if item.name != "Sulfuras, Hand of Ragnaros" do
            decrease_quality(item, 2)
          else
            item
          end

        item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
          if item.name != "Sulfuras, Hand of Ragnaros" do
            decrease_quality(item, 1)
          else
            item
          end

        true ->
          item = increase_quality(item, 1)

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
                  item.name != "Sulfuras, Hand of Ragnaros" ->
                    decrease_quality(item, 1)

                  true ->
                    item
                end

              true ->
                decrease_quality(item, item.quality)
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
