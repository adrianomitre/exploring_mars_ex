defmodule Reporter do
  def report_current_position(probe = %Probe{}) do
    pos_x = elem(probe.position, 0) |> round()
    pos_y = elem(probe.position, 1) |> round()

    orientation_first_letter =
      Probe.angle_to_orientation_first_letter()
      |> Map.fetch!(probe.direction)

    IO.puts("#{pos_x} #{pos_y} #{orientation_first_letter}")
  end
end
