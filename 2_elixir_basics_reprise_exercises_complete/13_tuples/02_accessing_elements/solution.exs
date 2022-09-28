defmodule Cards do
  def same_suit?(card1, card2), do: elem(card1, 1) == elem(card2, 1)
end
