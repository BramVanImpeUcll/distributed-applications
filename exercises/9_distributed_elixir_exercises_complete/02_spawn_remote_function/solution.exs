# From node pong:
Node.spawn(:"ping@LT2211617", fn ->
  IO.puts("Hello world on node: #{to_string(Node.self())}")
end)
