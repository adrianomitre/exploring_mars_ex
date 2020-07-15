defmodule MarsExploration do
  @moduledoc """
    Process input lines.
  """

  def process_plateau_definition(line) when is_binary(line) do
    %Plateau{
      upper_rightmost_position: Parser.parse_position(line)
    }
  end

  def parse_probe(line, plateau = %Plateau{}) when is_binary(line) do
    %Probe{
      plateau: plateau,
      position: Parser.parse_position(line),
      direction: Parser.parse_direction(line)
    }
  end

  def applying_commands(probe = %Probe{}, commands, abort_on_invalid_command \\ false) do
    commands
    |> Enum.reduce(probe, fn command_to_apply, updated_probe ->
      if abort_on_invalid_command and Probe.valid_command?(probe, command_to_apply) do
        raise "Invalid command"
      else
        Probe.applying_command(updated_probe, command_to_apply)
      end
    end)
  end
end
