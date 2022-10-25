defmodule Echo do

  def loop(next \\ nil) do
    receive do
      {:echo , message , from} ->
        shout_to(next , from , message)
        loop(next)

      {:update_next , new_next} ->
        loop(new_next)
    end
  end

  defp shout_to(nil, from , msg) do
    shout(from , msg)
  end

  defp shout_to(pid, from , msg) do
    echo_msg = shout(from , msg)
    send(pid, {:echo , echo_msg , self()})
  end

  defp shout(from , msg) do
    :timer.sleep(50)
    echo_msg = "#{inspect(from)}: #{msg}"
    IO.puts("\n" <> echo_msg)
    echo_msg
  end
end

# c "6_demo_echoes.exs"
# pid_A = spawn(Echo , :loop , [])
# pid_B = spawn(Echo , :loop , [])
# pid_C = spawn(Echo , :loop , [])

# send(pid_A , {:update_next , pid_B})
# send(pid_B , {:update_next , pid_C})

# send(pid_A , {:echo , "Hello world", self()})
