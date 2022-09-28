defmodule Rectangle do
  def area(a, b) do
    a * b
  end

  def area(a) do
    area(a, a)
  end
end
