# Run this in iex

query =
  fn query_def ->
    Process.sleep(2000)
    "#{query_def} result"
end

query.("Query 1")
Enum.map([1, 2, 3, 4, 5], fn x -> query.("Query #{x}") end) # Results after ten seconds


spawn(fn -> query.("Query 1") end) # Zien geen output want print in Thread
spawn(fn -> IO.puts(query.("Query 1")) end)


# Closure om data mee te geven
async_query =
  fn query_def ->
    spawn(fn -> IO.puts(query.(query_def)) end)
end

async_query.("Async Query 1") # Still takes two seconds
Enum.map([1, 2, 3, 4, 5], fn x -> async_query.("Query #{x}") end) # Results after two seconds
