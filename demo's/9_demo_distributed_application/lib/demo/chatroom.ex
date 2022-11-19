defmodule Demo.Chatroom do
  use GenServer
  @me __MODULE__

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
    GenServer.call(via_tuple(room_name), {:send_msg, self(), Node.self(), msg})
  end

  def participate(room_name, username) do
    GenServer.call(via_tuple(room_name), {:participate, self(), Node.self(), username})
  end

  def get_state(room_name) do
    GenServer.call(via_tuple(room_name), {:get_state})
  end

  # CALLBACKS

  @impl true
  @spec init(any) :: {:ok, %Demo.Chatroom{chat_room: any, messages: [], participants: []}}
  def init(room_name), do: {:ok, %@me{chat_room: room_name}}

  @impl true
  def handle_call({:participate, pid, node, username}, _, %@me{participants: ps} = state) do
    case Enum.find(ps, fn {ps_pid, node_pid, _} -> ps_pid == pid and node_pid == node end) do
      {_, _, _} ->
        {:reply, {:error, :already_participating}, state}

      nil ->
        new_state = %{state | participants: [{pid, node, username} | state.participants]}
        {:reply, :ok, new_state}
    end
  end

  @impl true
  def handle_call({:send_msg, pid, node, msg}, _, %@me{participants: ps} = state) do
    case Enum.find(ps, fn {ps_pid, node_pid, _} -> ps_pid == pid and node_pid == node end) do
      {_, _, sender} ->
        # You could send a message to all participants
        new_state = %{state | messages: [create_msg_entry(sender, msg) | state.messages]}
        {:reply, :ok, new_state}

      nil ->
        {:reply, {:error, :not_a_participating_member}, state}
    end
  end

  @impl true
  def handle_call({:get_state}, _, %@me{} = state) do
    {:reply, {:ok, state}, state}
  end

  # HELPER FUNCTIONS
  defp create_msg_entry(sender, msg) do
    timestamp = DateTime.utc_now()
    {timestamp, sender, msg}
  end

  defp via_tuple(room_name) do
    {:via, :global, {:chat_room, room_name}}
  end
end
