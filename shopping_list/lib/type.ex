defmodule ShoppingList.Type do
  @type item :: %{
          name: String.t(),
          quantity: Integer.t(),
          unit_price: Integer.t()
        }

  @type item_list :: [item]

  @type buyer :: %{
          name: String.t(),
          email: String.t()
        }

  @type buyer_list :: [buyer]

  @type result_list_unformatted :: %{
          required(Integer.t()) => String.t()
        }

  @type result_list_formatted :: %{
          required(String.t()) => String.t()
        }
end
