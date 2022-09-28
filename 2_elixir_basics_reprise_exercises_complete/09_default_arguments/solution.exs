defmodule Language do
  def greeting(salutation \\ "Hello", name) do
    salutation <> " " <> name
  end
end
