defmodule Demo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    {_, node1} = Application.fetch_env(:demo, :node1)
    Node.connect(node1)

    {_, node2} = Application.fetch_env(:demo, :node2)
    Node.connect(node2)

    children = [
      {Demo.ChatroomDynamicSupervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Demo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
