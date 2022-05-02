defmodule ShoppingList.Impl.Helpers.Money do
  @spec from_string(String.t()) :: Integer.t()
  def from_string(value),
    do: value |> String.replace(~r/((R\$)|(,)|(\.)|( ))/i, "") |> String.to_integer()

  @spec to_string(Integer.t()) :: String.t()
  def to_string(value) do
    [value, cents] = (value / 100) |> Float.to_string() |> String.split(".", trim: true)
    value_formatted = String.replace(value, ~r/\B(?=(\d{3})+(?!\d))/i, ".")
    cents_formatted = String.pad_leading(cents, 2, "0") |> String.slice(0, 2)
    "R$ #{value_formatted},#{cents_formatted}"
  end
end
