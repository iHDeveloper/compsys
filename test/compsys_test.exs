defmodule CompSysTest do
  use ExUnit.Case
  doctest CompSys
  test "greets the world" do
    assert CompSys.hello() == :world
  end
end
