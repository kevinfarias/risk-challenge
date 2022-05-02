defmodule ShoppingListTest do
  use ExUnit.Case

  alias ShoppingList.Impl.List

  test "it must sum all items correctly" do
    item_list = [
      %{
        name: "Cebola",
        quantity: 3,
        unit_price: 1
      },
      %{
        name: "Tomate",
        quantity: 2,
        unit_price: 1.5
      },
      %{
        name: "Alface",
        quantity: 4,
        unit_price: 1
      }
    ]

    final_price = item_list |> List.sum_item_list()

    assert final_price == 1000
  end

  # test "it must distribute the price between the buyers list" do
  #   item_list = [
  #     %{
  #       name: "Cebola",
  #       quantity: 3,
  #       unit_price: 1
  #     },
  #     %{
  #       name: "Tomate",
  #       quantity: 2,
  #       unit_price: 1.5
  #     },
  #     %{
  #       name: "Alface",
  #       quantity: 4,
  #       unit_price: 1
  #     }
  #   ]

  #   buyers_list = [
  #     %{
  #       name: "Kevin Farias",
  #       email: "kevin@farias.com"
  #     },
  #     %{
  #       name: "John Doe",
  #       email: "john@doe.com"
  #     },
  #     %{
  #       name: "Jane Doe",
  #       email: "jane@doe.com"
  #     }
  #   ]

  #   {:ok, distribute_price_result} = item_list |> List.distribute_price(buyers_list)

  #   expected_result = %{
  #     "kevin@farias.com": "R$ 3,33",
  #     "john@doe.com": "R$ 3,33",
  #     "jane@doe.com": "R$ 3,34"
  #   }

  #   assert expected_result == distribute_price_result
  # end
end
