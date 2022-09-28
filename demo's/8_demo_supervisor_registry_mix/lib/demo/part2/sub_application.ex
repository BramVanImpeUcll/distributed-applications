defmodule Demo.Part2.SubApplication do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {Registry, keys: :unique, name: Demo.Part2.ChatRoomRegistry},
      {Demo.Part2.ChatroomsDynamicSupervisor, []}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
