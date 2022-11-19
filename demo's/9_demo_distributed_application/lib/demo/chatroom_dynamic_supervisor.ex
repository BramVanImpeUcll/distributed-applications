defmodule Demo.ChatroomDynamicSupervisor do
  # Automatically defines child_spec/1
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_chatroom(room_name) do
    DynamicSupervisor.start_child(__MODULE__, {Demo.Chatroom, room_name})
  end
end
