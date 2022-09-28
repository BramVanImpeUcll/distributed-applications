defmodule Demo.Part2.ChatRoomSupervisor do
  use Supervisor

  alias Demo.Part2.ChatRoomRegistry

  def start_link(init_arg) do
    case init_arg[:room_name] do
      nil ->
        {:error, {:missing_arg, :room_name}}

      room_name ->
        via_tuple = {:via, Registry, {ChatRoomRegistry, {:chat_room_supervisor, room_name}}}
        Supervisor.start_link(__MODULE__, init_arg, name: via_tuple)
    end
  end

  @impl true
  def init(init_arg) do
    children = [{Demo.Part2.ChatRoomV2, init_arg}]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
