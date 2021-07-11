defmodule CompSys.Entity.Registry do
  alias CompSys.Entity
  use GenServer
  @moduledoc """
  Registry to interact with named entities
  """

  # Client Implementation

  @doc """
  Starts the registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up for the entity pid in `server`
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Creates an entity with given `name` in the `server`
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  # Server Implementation

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, entity} = Entity.start_link([])
      {:noreply, Map.put(names, name, entity)}
    end
  end
end
