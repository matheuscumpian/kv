defmodule KV.Bucket do
  use Agent, restart: :temporary

  @spec start_link(opts :: list(keyword())) :: {:error, any} | {:ok, pid}
  @doc """
    Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @spec get(atom() | pid(), any) :: any
  @doc """
    Get a value from the `bucket` by `key`
  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  @spec put(atom() | pid(), any, any) :: :ok
  @doc """
    Puts the `value` for the given `key` in the `bucket`
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  @spec delete(atom() | pid(), any) :: any
  @doc """
    Deletes `key` from `bucket`

    Returns the current `value` for `key` if `key` exists
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
