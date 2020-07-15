defmodule PlateauTest do
  use ExUnit.Case

  doctest Plateau

  test "within_boundaries?" do
    assert Plateau.within_boundaries?(%Plateau{upper_rightmost_position: {5, 5}}, {0, 0})
    assert Plateau.within_boundaries?(%Plateau{upper_rightmost_position: {5, 5}}, {5, 5})
    assert !Plateau.within_boundaries?(%Plateau{upper_rightmost_position: {5, 5}}, {3, 7})
    assert !Plateau.within_boundaries?(%Plateau{upper_rightmost_position: {5, 5}}, {7, 3})
  end
end
