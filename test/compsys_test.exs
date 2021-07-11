defmodule CompsysTest do
  use ExUnit.Case
  doctest Compsys

  test "greets the world" do
    assert Compsys.hello() == :world
  end
end
