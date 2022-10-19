defmodule BrowserCounter do
  use GenServer

  # Interface functions
  def start() do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def request_browsers(pid) do
    GenServer.call(pid, :retrieve_browsers)
  end

  def add_browser_hit(pid, browser) do
    GenServer.cast(pid, {:browser_hit, browser})
  end

  # Callback Modules
  @impl GenServer
  def init(_), do: {:ok, %{}}

  @impl GenServer
  def handle_call(:retrieve_browsers, _from, state) do
    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast({:browser_hit, browser}, state) do
    new_state =
      case Map.fetch(state, browser) do
        :error -> Map.put_new(state, browser, 1)
        {:ok, n} -> Map.put(state, browser, n + 1)
      end

    {:noreply, new_state}
  end
end

# Navigate to directory where this file is
# start iex
# execute:

# c "5_demo_browsers_genserver.exs" (compiles and loads in the file, beats copy-pasting)
# {_, pid} = BrowserCounter.start()
# BrowserCounter.request_browsers(pid)
# BrowserCounter.add_browser_hit(pid, :firefox)
# BrowserCounter.request_browsers(pid)
