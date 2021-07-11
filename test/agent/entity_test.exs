defmodule CompSysTest.Entity do
  alias CompSys.Entity
  use ExUnit.Case, async: true
  doctest Entity

  setup do
    {:ok, entity} = Entity.start_link("test-subject")
    %{entity: entity}
  end

  test "check if the entity exists at all", %{entity: entity} do
    assert entity != nil
  end

  test "gets a non-existent value from entity", %{entity: entity} do
    assert Entity.get(entity, :position) == nil
  end

  test "stores a value in the entity", %{entity: entity} do
    assert Entity.put(entity, :position, [x: 0, y: 0]) == :ok
    assert [x: x, y: y] = Entity.get(entity, :position)
    assert x == 0 && y == 0
  end
end
