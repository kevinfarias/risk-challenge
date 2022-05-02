defmodule ShoppingList.Impl.List do
  alias ShoppingList.Type

  # {:ok, result_list} | {:error, String.t()}
  @spec sum_item_list(Type.item_list()) :: Integer.t()
  def sum_item_list(item_list),
    do: Enum.reduce(item_list, 0, fn acc, row -> acc + row.unit_price * row.quantity end)
end
