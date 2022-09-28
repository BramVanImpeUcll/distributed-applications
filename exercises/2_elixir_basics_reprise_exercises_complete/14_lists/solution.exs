defmodule Util do
  def range(a, b) do
    if b >= a do
      [a | range(a + 1, b)]
    else
      []
    end
  end
end

