defmodule Demo.Part2.ChatRoomV2 do
  use GenServer
  @me __MODULE__

  alias Demo.Part2.ChatRoomRegistry

  @enforce_keys [:chat_room]
  defstruct messages: [], participants: [], chat_room: nil

  # API

  def start_link(nil) do
    {:error, {:missing_arg, :room_name}}
  end

  def start_link(room_name) do
    GenServer.start_link(@me, room_name, name: via_tuple(room_name))
  end

  def send_msg(room_name, msg) do
    GenServer.call(via_tuple(room_name), {:send_msg, self(), msg})
  end

  def participate(room_name) do
    GenServer.call(via_tuple(room_name), {:participate, self()})
  end

  # CALLBACKS

  @impl true
  def init(room_name), do: {:ok, %@me{chat_room: room_name}}

  @impl true
  def handle_call({:participate, pid}, _, %@me{participants: ps} = state) do
    readable_name = retrieve_sender_name(pid)

    with {:registered?, name} when not is_nil(name) <- {:registered?, readable_name}, # Elixir with statement: https://elixirschool.com/en/lessons/basics/control_structures#with-3
         {:participating?, false} <- {:participating?, name in ps} do
      new_state = %{state | participants: [name | state.participants]}
      {:reply, :ok, new_state}
    else
      error ->
        {:reply, error, state}
    end
  end

  @impl true
  def handle_call({:send_msg, sender_pid, msg}, _, %@me{participants: ps} = state) do
    sender = retrieve_sender_name(sender_pid)

    case sender in ps do
      true ->
        # You could send a message to all participants
        new_state = %{state | messages: [create_msg_entry(sender, msg) | state.messages]}
        {:reply, :ok, new_state}

      false ->
        {:reply, {:error, :not_a_participating_member}, state}
    end
  end

  # HELPER FUNCTIONS

  defp retrieve_sender_name(pid) when is_pid(pid) do
    case Registry.keys(ChatRoomRegistry, pid) do
      [] -> nil
      [sender] -> sender
    end
  end

  defp create_msg_entry(sender, msg) do
    timestamp = DateTime.utc_now()
    {timestamp, sender, msg}
  end

  defp via_tuple(room_name) do
    {:via, Registry, {ChatRoomRegistry, {:chat_room, room_name}}}
  end
end

defmodule ExampleServer do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(id) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
  end

  def call(id, some_request) do
    GenServer.call(via_tuple(id), some_request)
  end

  defp via_tuple(id) do
    {:via, Registry, {:my_registry, {__MODULE__, id}}}
  end

  def handle_call(some_request, _, state) do
    {:reply, some_request, state}
  end
end
