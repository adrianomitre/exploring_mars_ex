defmodule Parser do
  @moduledoc """
    Parse plateau and probe specs, as well as probe commands.
  """

  @char_to_command %{
    L: :turn_left,
    R: :turn_right,
    M: :move_forward
  }

  def parse_commands(line) when is_binary(line) do
    validate_syntax_for_commands(line)

    line
    |> String.replace(~r/\s+/, "")
    |> String.graphemes()
    |> Enum.map(&String.to_atom/1)
    |> Enum.map(fn grapheme_atom -> Map.fetch!(@char_to_command, grapheme_atom) end)
  end

  def parse_position(line) when is_binary(line) do
    validate_syntax_for_position_with_optional_direction(line)

    String.split(line)
    |> Enum.take(2)
    |> Enum.map(&String.to_integer/1)
  end

  def parse_direction(line) when is_binary(line) do
    validate_syntax_for_position_with_optional_direction(line)
    angle_from_valid_line(line)
  end

  defp angle_from_valid_line(line) when is_binary(line) do
    orientation_first_letter = List.last(String.split(line))
    Probe.angle_from_orientation_first_letter(orientation_first_letter)
  end

  defp validate_syntax_for_commands(line) when is_binary(line) do
    unless String.match?(line, ~r/^[lrm ]*$/i) do
      # SyntaxError
      raise "invalid syntax for commands"
    end

    true
  end

  defp validate_syntax_for_position_with_optional_direction(line) when is_binary(line) do
    unless String.match?(line, ~r/^\s*\d+\s\d+(?:\s+[ENWS])?\s*$/) do
      raise "Invalid syntax for position with optional direction"
    end
    true
  end
end
