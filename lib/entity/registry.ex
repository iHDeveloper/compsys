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
  def start_link(opts \\ []) do
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
    GenServer.call(server, {:create, name})
  end

  # Server Implementation

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  @impl true
  def handle_call({:create, name}, _from, {names, refs}) do
    if Map.has_key?(names, name) do
      {:ok, entity} = Map.fetch(names, name)
      {:reply, entity, {names, refs}}
    else
      {:ok, entity} = Entity.start_link([])
      ref = Process.monitor(entity)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, entity)
      {:reply, entity, {names, refs}}
    end
  end

  @impl true
  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end

end
