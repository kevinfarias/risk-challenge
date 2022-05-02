defmodule ShoppingList do
  alias ShoppingList.Type
  alias ShoppingList.Impl.List

  @spec calculate(Type.item_list(), Type.buyer_list()) ::
          {:ok, Type.result_list_formatted()} | {:error, String.t()}
  defdelegate calculate(item_list, buyer_list), to: List, as: :distribute_price
end
