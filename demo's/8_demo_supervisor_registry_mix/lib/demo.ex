defmodule Demo do
  @default_chat_room :general_chat

  alias Demo.Part2.ChatroomsDynamicSupervisor
  alias Demo.Part2.ChatRoomRegistry
  alias Demo.Part2.ChatRoomV2

  @spec dump_all_registered_processes :: list
  def dump_all_registered_processes() do
    Registry.select(ChatRoomRegistry, [
      {{:"$1", :"$2", :"$3"}, [], [{{:"$1", :"$2", :"$3"}}]}
    ])
  end

  def run_setup() do
    {:ok, _} = ChatroomsDynamicSupervisor.start_chatroom(@default_chat_room)

    Registry.register(
      ChatRoomRegistry,
      {@default_chat_room, :participant, "iex_shell"},
      :ignore_value
    )

    ChatRoomV2.participate(@default_chat_room)
  end

  def send_msg() do
    ChatRoomV2.send_msg(@default_chat_room, "hi")
  end
end
