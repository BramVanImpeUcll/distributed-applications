defmodule GenericServer do

  def start(application_module) do
    spawn(fn ->
      initial_state = application_module.init()
      loop(application_module, initial_state)
    end)
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} -> response
    after
      5000 -> {:error, :timeout}
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
    :ok
  end

  defp loop(application_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} = application_module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(application_module, new_state)

      {:cast, request} ->
        new_state = application_module.handle_cast(request, current_state)
        loop(application_module, new_state)

      # Safeguard, ignore unexpected messages
      {any_message} ->
        loop(application_module, current_state)
    end
  end
end

defmodule BrowserCounter do

  # Interface functions
  def start() do
    GenericServer.start(BrowserCounter)
  end

  def request_browsers(pid) do
    GenericServer.call(pid, {:retrieve_browsers})
  end

  def add_browser_hit(pid, browser) do
    GenericServer.cast(pid, {:browser_hit, browser})
  end

  # Callback Modules
  def init() do
    %{}
  end

  def handle_call({:retrieve_browsers}, state) do
   {state, state}
  end

  def handle_cast({:browser_hit, browser}, state) do
    case Map.fetch(state, browser) do
      :error -> Map.put_new(state, browser, 1)
      {:ok, n} -> Map.put(state, browser, n + 1)
    end
  end
end

# Navigate to directory where this file is
# start iex
# execute:

# c "5_demo_browsers_server_process.exs" (compiles and loads in the file, beats copy-pasting)
# pid = BrowserCounter.start()
# BrowserCounter.request_browsers(pid)
# BrowserCounter.add_browser_hit(pid, :firefox)
# BrowserCounter.request_browsers(pid)
