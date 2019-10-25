defmodule Boss do
  @moduledoc false
  use Supervisor

  def start_link(_init_arg) do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_init_arg) do
    children = [ %{
    id: Worker,
    start: {Worker, :init, []}
  }]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
