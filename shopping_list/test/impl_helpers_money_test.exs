defmodule ImplMoneyTest do
  use ExUnit.Case

  alias ShoppingList.Impl.Helpers.Money

  test "it must transform a real to integer" do
    value = Money.from_string("R$ 10,00")
    value2 = Money.from_string("R$ 999.999,12")
    value3 = Money.from_string("R$ 9.999.999,12")

    assert value == 1000
    assert value2 == 99_999_912
    assert value3 == 999_999_912
  end

  test "it must transform a integer to real" do
    value = Money.to_string(1000)
    value2 = Money.to_string(99_999_912)
    value3 = Money.to_string(999_999_912)

    assert value == "R$ 10,00"
    assert value2 == "R$ 999.999,12"
    assert value3 == "R$ 9.999.999,12"
  end
end
