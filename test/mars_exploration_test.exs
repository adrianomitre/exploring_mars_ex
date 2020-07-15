defmodule MarsExplorationTest do
  use ExUnit.Case

  doctest MarsExploration

  test "raise on invalid command" do
    probe = %Probe{
      plateau: %Plateau{upper_rightmost_position: {5, 5}},
      position: [0, 0],
      direction: 0
    }

    commands = List.duplicate(:move_forward, 10)

    assert_raise RuntimeError, fn ->
      MarsExploration.applying_commands(probe, commands, true)
    end
  end
end
