defmodule ExploringMarsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest ExploringMars

  @sample_input """
  5 5
  1 2 N
  LMLMLMLMM
  3 3 E
  MMRMMRMRRM
  """

  @sample_output """
  1 3 N
  5 1 E
  """

  test "sample input and output" do
    {:ok, pid} = StringIO.open(@sample_input)
    stream = IO.stream(pid, :line)
    actual = capture_io(:stdio, fn -> ExploringMars.process_stream(stream) end)
    StringIO.close(pid)
    assert actual == @sample_output
  end
end
