defmodule Demo.Part1.GeneralChatRoomV1 do
  use GenServer
  @me __MODULE__

  defstruct messages: [], participants: %{} # https://elixir-lang.org/getting-started/structs.html

  # API

  def start_link(args \\ []), do: GenServer.start_link(@me, args, name: @me)
  def send_msg(msg), do: GenServer.call(@me, {:send_msg, self(), msg})
  def participate(name), do: GenServer.call(@me, {:participate, name, self()})

  # CALLBACKS

  @impl true
  def init(_args), do: {:ok, %@me{}}

  @impl true
  def handle_call({:participate, _, pid}, _, %@me{} = state)
      when is_map_key(state.participants, pid) do # Match op Struct type and assign to variable
    {:reply, {:error, :already_participating}, state}
  end

  @impl true
  def handle_call({:participate, name, pid}, _, %@me{} = state) do
    new_state = %{state | participants: Map.put_new(state.participants, pid, name)}
    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:send_msg, sender_pid, _msg}, _, %@me{} = state)
      when not is_map_key(state.participants, sender_pid) do
    {:reply, {:error, :not_a_participating_member}, state}
  end

  @impl true
  def handle_call({:send_msg, sender_pid, msg}, _, %@me{} = state) do
    sender_readable_name = Map.fetch!(state.participants, sender_pid)
    timestamp = DateTime.utc_now()
    message_entry = {timestamp, sender_readable_name, msg}
    # You could send a message to all participants that a new message has been sent
    new_state = %{state | messages: [message_entry | state.messages]}
    {:reply, :ok, new_state}
  end
end
