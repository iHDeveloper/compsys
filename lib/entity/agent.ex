defmodule CompSys.Entity do
  use Agent
  @moduledoc """
  Client API for interacting with Entity agent
  """

  @spec start_link() :: {:error, nil} | {:ok, pid}
  @doc """
  Start a new entity
  """
  def start_link() do
    {state, entity} = Agent.start_link(fn -> %{} end)
    if state == :ok do
      {:ok, entity}
    else
      {:error, nil}
    end
  end

  @spec get(atom | pid | {atom, any} | {:via, atom, any}, atom) :: any
  @doc """
  Get a component from an entity
  """
  def get(entity, key) when is_atom(key) do
    Agent.get(entity, &Map.get(&1, key))
  end

  @spec put(atom | pid | {atom, any} | {:via, atom, any}, atom, any) :: :ok
  @doc """
  Put a component in the entity
  """
  def put(entity, key, value) when is_atom(key) do
    Agent.update(entity, fn (state) -> Map.put(state, key, value) end)
  end

end
