defmodule Plateau do
  @moduledoc """
    Plateau in Mars, does boundary verification.
  """

  @enforce_keys [:upper_rightmost_position]
  defstruct [:upper_rightmost_position]

  def within_boundaries?(plateau = %Plateau{}, position = {x, y})
      when is_integer(x) and is_integer(y) do
    0..1
    |> Enum.all?(fn i -> elem(position, i) in get_range(plateau, i) end)
  end

  defp get_range(plateau = %Plateau{}, i) do
    0..elem(plateau.upper_rightmost_position, i)
  end
end
