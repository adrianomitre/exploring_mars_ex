defmodule ProbeTest do
  use ExUnit.Case

  doctest Probe

  @plateau %Plateau{upper_rightmost_position: {5, 5}}

  @probe %Probe{
    plateau: @plateau,
    position: [0, 0],
    direction: 0
  }

  test "valid_command?" do
    assert Probe.valid_command?(@probe, :move_forward)
  end

  test "invalid command" do
    probe = %{
      @probe
      | position: [0, 5],
        direction: Probe.orientation_first_letter_to_angle() |> Map.fetch!(:N)
    }

    assert !Probe.valid_command?(probe, :move_forward)
  end
end
