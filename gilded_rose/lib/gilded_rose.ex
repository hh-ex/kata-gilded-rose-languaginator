defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: "Conjured Item"} = item) do
    item
    |> change_sell_in(-1)
    |> change_quality(-2)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> change_sell_in(-1)
    |> change_quality(1)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item
    |> change_sell_in(-1)
    |> change_quality_backstage
  end

  def update_item(%Item{} = item) do
    item
    |> change_sell_in(-1)
    |> change_quality(-1)
  end

  defp change_sell_in(%Item{sell_in: sell_in} = item, amount) do
    %Item{item | sell_in: sell_in + amount}
  end

  # defp change_quality(%Item{quality: quality} = item, amount) do
  defp change_quality(%Item{quality: quality, sell_in: sell_in} = item, amount) do
    amount =
      cond do
        sell_in < 0 ->
          amount * 2

        true ->
          amount
      end

    quality =
      quality
      |> Kernel.+(amount)
      |> max(0)
      |> min(50)

    %Item{item | quality: quality}
  end

  defp change_quality_backstage(%Item{sell_in: sell_in, quality: quality} = item) do
    cond do
      sell_in < 0 ->
        change_quality(item, -quality)

      sell_in < 5 ->
        change_quality(item, 3)

      sell_in < 10 ->
        change_quality(item, 2)

      true ->
        change_quality(item, 1)
    end
  end
end
