defmodule ShoppingList.Impl.Iterator do
  alias ShoppingList.Type

  @spec iterate(Type.buyer_list(), Integer.t(), Integer.t()) :: Type.result_list_formatted()

  def iterate([head | []], value_each_buyer, rest_of_value_division) do
    %{
      head.email => value_each_buyer + rest_of_value_division
    }
  end

  def iterate([head | tail], value_each_buyer, rest_of_value_division) do
    Map.merge(
      %{
        head.email => value_each_buyer
      },
      iterate(tail, value_each_buyer, rest_of_value_division)
    )
  end
end
