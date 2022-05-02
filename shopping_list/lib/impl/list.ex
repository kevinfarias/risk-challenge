defmodule ShoppingList.Impl.List do
  alias ShoppingList.Type
  alias ShoppingList.Impl.Iterator
  alias ShoppingList.Impl.Helpers.Money

  @spec sum_item_list(Type.item_list()) :: Integer.t()
  def sum_item_list(item_list),
    do: Enum.reduce(item_list, 0, fn row, acc -> acc + row.unit_price * row.quantity end)

  @spec distribute_price(Type.item_list(), Type.buyer_list()) ::
          {:ok, Type.result_list_formatted()} | {:error, String.t()}
  def distribute_price([], []), do: {:error, "The two lists must contain values!"}

  def distribute_price(_item_list, []), do: {:error, "The buyer list must contain values!"}

  def distribute_price([], _buyer_list), do: {:error, "The item list cannot be empty"}

  def distribute_price(item_list, buyer_list) do
    total_value = item_list |> sum_item_list |> trunc
    total_buyers = buyer_list |> length |> trunc

    cond do
      total_value <= 0 ->
        {:error, "You must pass a list with valid values (bigger than 0)"}

      total_value > 0 ->
        {:ok,
         Iterator.iterate(
           buyer_list,
           total_value / total_buyers,
           rem(total_value, total_buyers)
         )
         |> present_in_human_format()}
    end
  end

  @spec present_in_human_format(Type.result_list_unformatted()) :: Type.result_list_formatted()
  defp present_in_human_format(final_list),
    do: final_list |> Enum.map(fn {k, v} -> {k, Money.to_string(v)} end) |> Enum.into(%{})
end
