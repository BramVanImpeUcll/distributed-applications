defmodule Stack do
  use GenServer

  ## Interface Functions ##

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def pop() do
    GenServer.call(Stack, :pop)
  end

  def push(data) do
    GenServer.cast(Stack, {:push, data})
  end

  ## Callbacks ##

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, head}, tail) do
    {:noreply, [head | tail]}
  end

  # This is equivalent to the default implementation of child_spec
  def child_spec(arg) do
    %{
      id: Stack,
      start: {Stack, :start_link, [arg]}
    }
  end
end

defmodule MyApp.Supervisor do
  use Supervisor # Automatically defines child_spec/1 for use in supervision tree

  def start_link(stack) do
    Supervisor.start_link(__MODULE__, stack, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = [
      {Stack, [:hello]}
    ]

    Supervisor.init(children, strategy: :one_for_one) # inits all the children
  end
end

# DEMO CODE

# iex
# c "7_demo_supervisor.exs"

# children = [
#   %{
#     id: Stack,
#     start: {Stack, :start_link, [[:hello]]}
#   }
# ]
# {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
# After started, we can query the supervisor for information
# Supervisor.count_children(pid)
# Stack.pop()
# Stack.push(:world)
# Stack.pop()
# Stack.pop()
# Supervisor.count_children(pid)

# Alternative: Uncomment Child Spec in Stack
# children = [
#  {Stack, [:hello]}
# ]
# {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
# After started, we can query the supervisor for information
# Supervisor.count_children(pid)
# Stack.pop()
# Stack.push(:world)
# Stack.pop()
# Stack.pop()
# Supervisor.count_children(pid)

# Alternative: Uncomment Child Spec in Stack,
# Child is started without arguments using this syntax
# children = [
#  Stack
# ]
# {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
# After started, we can query the supervisor for information
# Supervisor.count_children(pid)
# Stack.pop()
# Supervisor.count_children(pid)

# Alternative: Uncomment Module Based Supervisor
# MyApp.Supervisor.start_link(:hello)
# After started, we can query the supervisor for information
# Supervisor.count_children(MyApp.Supervisor)
# Stack.pop()
# Stack.push(:world)
# Stack.pop()
# Stack.pop()
# Supervisor.count_children(MyApp.Supervisor)
