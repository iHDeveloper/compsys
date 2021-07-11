defmodule CompSysTest do
  use ExUnit.Case
  doctest CompSys

  test "launch returns okay" do
    assert CompSys.launch() == :ok
  end

  test "destroy returns okay" do
    assert CompSys.destroy() == :ok
  end
end
