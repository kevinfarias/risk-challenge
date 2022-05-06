defmodule ShoppingList.Impl.Iterator do
  alias ShoppingList.Type

  @spec iterate(Type.buyer_list(), Integer.t(), Integer.t()) :: Type.result_list_formatted()

  def iterate([], _value_each_buyer, _rest_of_value_division), do: %{}

  def iterate([head | tail], value_each_buyer, rest_of_value_division)
      when rest_of_value_division > 0 do
    Map.merge(
      %{
        head.email => value_each_buyer + 1
      },
      iterate(tail, value_each_buyer, rest_of_value_division - 1)
    )
  end

  def iterate([head | tail], value_each_buyer, 0) do
    Map.merge(
      %{
        head.email => value_each_buyer
      },
      iterate(tail, value_each_buyer, 0)
    )
  end
end
