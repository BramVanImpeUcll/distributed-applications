defmodule Echo do

  def init(next \\ nil) do
    loop(next)
  end

  def loop(next \\ nil) do
    receive do
      {:echo, message, from} ->
        shout_to(next, from, message)
        loop(next)

      {:update_next, from} ->
        new_next = spawn(Echo , :init , [])
        Process.monitor(new_next)
        send(from, {new_next})
        loop(new_next)

      {:die} ->
        raise("I died")

      random_msg ->
        IO.puts("Random message:")
        IO.inspect(random_msg)
        loop(next)
    end
  end

  defp shout_to(nil, from, msg) do
    shout(from, msg)
  end

  defp shout_to(pid, from, msg) do
    echo_msg = shout(from, msg)
    send(pid, {:echo, echo_msg, self()})
  end

  defp shout(from, msg) do
    :timer.sleep(50)
    echo_msg = "#{inspect(from)}: #{msg}"
    IO.puts("\n" <> echo_msg)
    echo_msg
  end
end


# c "6_demo_echoes_monitors.exs"
# pid_A = spawn(Echo , :init , [])

# send(pid_A, {:update_next, self()})
# pid_B = receive do
#  {new_pid} -> new_pid
# end

# send(pid_B , {:update_next, self()})
# pid_C = receive do
#  {new_pid} -> new_pid
# end

# send(pid_A , {:echo , "Hello world", self()})

# send(pid_C, {:die})

# send(pid_C , {:echo , "Hello world", self()})
# send(pid_A , {:echo , "Hello world", self()})
