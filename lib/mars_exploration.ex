defmodule MarsExploration do
  @moduledoc """
    Process input lines.
  """

  def process_plateau_definition(line) do
    %Plateau{
      upper_rightmost_position: Parser.parse_position(line)
    }
  end

  def process_probe_definition(line, plateau) do
    %Probe{
      plateau: plateau,
      position: Parser.parse_position(line),
      direction: Parser.parse_direction(line)
    }
  end

  def process_probe_commands(probe, line) do
    Parser.parse_commands(line)
    |> Enum.reduce(probe, fn command_to_apply, updated_probe ->
      # unless @probe.valid_command?(cmd)
      #   raise(ArgumentError, "Invalid command #{cmd}, skipping probe")
      # end
      # @probe.send(cmd)
      Probe.applying_command(updated_probe, command_to_apply)
    end)
  end
end
