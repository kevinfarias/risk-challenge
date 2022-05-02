defmodule ShoppingListTest do
  use ExUnit.Case

  alias ShoppingList.Impl.List

  test "it must sum all items correctly" do
    item_list = [
      %{
        name: "Cebola",
        quantity: 3,
        unit_price: 100
      },
      %{
        name: "Tomate",
        quantity: 2,
        unit_price: 150
      },
      %{
        name: "Alface",
        quantity: 4,
        unit_price: 100
      }
    ]

    final_price = item_list |> List.sum_item_list()

    assert final_price == 1000
  end

  test "it must throw an error when the one of the two lists are empty" do
    item_list = [
      %{
        name: "Cebola",
        quantity: 3,
        unit_price: 0
      }
    ]

    buyers_list = [
      %{
        name: "Kevin Farias",
        email: "kevin@farias.com"
      }
    ]

    {:error, message} = List.distribute_price([], [])
    assert message == "The two lists must contain values!"

    {:error, message} = List.distribute_price(item_list, [])
    assert message == "The buyer list must contain values!"

    {:error, message} = List.distribute_price([], buyers_list)
    assert message == "The item list cannot be empty"

    {:error, message} = List.distribute_price(item_list, buyers_list)
    assert message == "You must pass a list with valid values (bigger than 0)"
  end

  test "it must distribute the price between the buyers list" do
    item_list = [
      %{
        name: "Cebola",
        quantity: 3,
        unit_price: 100
      },
      %{
        name: "Tomate",
        quantity: 2,
        unit_price: 150
      },
      %{
        name: "Alface",
        quantity: 4,
        unit_price: 100
      }
    ]

    buyers_list = [
      %{
        name: "Kevin Farias",
        email: "kevin@farias.com"
      },
      %{
        name: "John Doe",
        email: "john@doe.com"
      },
      %{
        name: "Jane Doe",
        email: "jane@doe.com"
      }
    ]

    {:ok, distribute_price_result} = item_list |> List.distribute_price(buyers_list)

    expected_result = %{
      "jane@doe.com" => "R$ 3,34",
      "john@doe.com" => "R$ 3,33",
      "kevin@farias.com" => "R$ 3,33"
    }

    assert expected_result == distribute_price_result
  end

  test "it must call the API interface successfully" do
    {:error, message} = ShoppingList.calculate([], [])

    assert message == "The two lists must contain values!"
  end
end
