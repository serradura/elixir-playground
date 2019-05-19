Code.load_file("#{__DIR__}/../../test_helper.exs")

defmodule TCOTests do
  use ExUnit.Case, async: false
  import TestHelper

  test_script "tco_list_len" do
    assert 0 == TCO.list_len([])
    assert 2 == TCO.list_len([1, 2])
    assert 4 == TCO.list_len([1, 2, 3, 4])
  end

  test_script "tco_positive" do
    assert [] == TCO.positive([:ok, "foo", 0, 0, 0, -1, -2])
    assert [1] == TCO.positive([0, 0, 0, 1, -1, -2, :ok, "foo"])
    assert [3, 1, 4] == TCO.positive([4, 0, 0, 0, 1, -1, -2, :ok, "foo", 3])
  end

  test_script "tco_range" do
    assert [3] == TCO.range(3, 3)
    assert [1, 2, 3] == TCO.range(1, 3)
    assert [3, 2, 1] == TCO.range(3, 1)

    assert [-5] == TCO.range(-5, -5)
    assert [-3, -4, -5] == TCO.range(-3, -5)
    assert [-5, -4, -3] == TCO.range(-5, -3)

    assert [-3, -2, -1, 0, 1, 2, 3] == TCO.range(-3, 3)
    assert [3, 2, 1, 0, -1, -2, -3] == TCO.range(3, -3)
  end
end
