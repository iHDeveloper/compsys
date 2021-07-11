defmodule CompSysTest.Entity.Registry do
  alias CompSys.Entity
  alias CompSys.Entity.Registry
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(Registry)
    %{registry: registry}
  end

  test "create entity with name \"iHDeveloper\"", %{registry: registry} do
    assert Registry.lookup(registry, "iHDeveloper") == :error

    Registry.create(registry, "iHDeveloper")
    assert {:ok, entity} = Registry.lookup(registry, "iHDeveloper")

    Entity.put(entity, :op, true)
    assert true = Entity.get(entity, :op)
  end

  test "remove entity on exit", %{registry: registry} do
    entity = Registry.create(registry, "iHDeveloper")
    Agent.stop(entity)
    assert Registry.lookup(registry, "iHDeveloper") == :error
  end
end
