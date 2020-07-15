defmodule Probe do
  @enforce_keys [:plateau, :position, :direction]
  defstruct [:plateau, :position, :direction]

  def orientation_first_letter_to_angle do
    %{
      _("East") => 0.0,
      _("North") => :math.pi() / 2,
      _("West") => :math.pi(),
      _("South") => :math.pi() * 3 / 2
    }
  end

  def angle_to_orientation_first_letter do
    Probe.orientation_first_letter_to_angle()
    |> invert_map()
  end

  defp invert_map(map = %{}) do
    Map.new(map, fn {key, val} -> {val, key} end)
    # More concise, readable and 5-26% faster than the following alternative:
    #   Enum.reduce(map, %{}, fn {k, vs}, acc -> Map.merge(acc, %{vs => k}) end)
  end

  defp _(direction_name) when is_binary(direction_name) do
    direction_name
    |> String.first()
    |> String.upcase()
    |> String.to_atom()
  end

  def angle_from_orientation_first_letter(orientation_first_letter)
      when is_binary(orientation_first_letter) do
    Probe.orientation_first_letter_to_angle()
    |> Map.fetch!(String.to_atom(orientation_first_letter))
  end

  def applying_command(probe = %Probe{}, command) when is_atom(command) do
    case command do
      :turn_left -> turn_left(probe)
      :turn_right -> turn_right(probe)
      :move_forward -> move_forward(probe)
    end
  end

  def turn_left(probe = %Probe{}) do
    turn(probe, -0.5 * :math.pi())
  end

  def turn_right(probe = %Probe{}) do
    turn(probe, 0.5 * :math.pi())
  end

  def move_forward(probe = %Probe{}, distance \\ 1) when is_number(distance) do
    next_pos =
      probe.position
      |> Enum.chunk_every(2)
      |> Enum.flat_map(fn [x, y] ->
        [
          x + :math.cos(probe.direction) * distance,
          y + :math.sin(probe.direction) * distance
        ]
      end)
      |> Enum.map(&Float.round/1)

    %Probe{
      probe
      | position: next_pos
    }
  end

  defimpl String.Chars, for: Probe do
    def to_string(probe = %Probe{}) do
      position =
        probe.position
        |> Enum.map(&round/1)
        |> Enum.join(" ")

      orientation_first_letter =
        Probe.angle_to_orientation_first_letter()
        |> Map.fetch!(probe.direction)

      "#{position} #{orientation_first_letter}"
    end
  end

  def valid_command?(probe = %Probe{}, command) when is_atom(command) do
    if command == :move_forward do
      Plateau.within_boundaries?(probe.plateau, move_forward(probe).position |> List.to_tuple())
    else
      true
    end
  end

  defp turn(probe = %Probe{}, degrees) when is_number(degrees) do
    next_dir = rem_float(probe.direction - degrees, 2 * :math.pi())
    %{probe | direction: next_dir}
  end

  defp rem_float(a, b) do
    x = a / b
    a - Float.floor(x) * b
  end
end
