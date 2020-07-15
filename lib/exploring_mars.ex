defmodule ExploringMars do
  # escript references:
  # https://hexdocs.pm/mix/1.10.4/Mix.Tasks.Escript.Build.html
  # https://medium.com/blackode/writing-the-command-line-application-in-elixir-78a8d1b1850
  # https://elixirschool.com/en/lessons/advanced/escripts/
  # http://davekuhlman.org/elixir-escript-mix.html
  #
  defmodule CLI do
    @moduledoc """
    synopsis:
      Prints args, possibly multiple times, possibly upper cased.
    usage:
      $ exploring_mars <input_file>
      or
      $ cat <input_file> | exploring_mars
    """

    def main(argv) do
      io_stream_from_file_args_or_stdin(argv)
      |> ExploringMars.process_stream()
    end

    defp io_stream_from_file_args_or_stdin(argv) do
      get_io_source(argv)
      |> IO.stream(:line)
    end

    defp get_io_source([]) do
      :stdio
    end

    defp get_io_source([path]) do
      # TODO: consider testing if the file exists and is readable
      # references: https://elixir-lang.org/getting-started/io-and-the-file-system.html

      # TODO: change the first to argv |> Enum.each(fn path -> yield File.stream!(path) end)
      # reference: https://stackoverflow.com/questions/58806048/pass-multiple-files-to-elixir-program-stdin
      {:ok, file} = File.open(path)
      file
    end
  end

  def process_stream(stream = %IO.Stream{}) do
    [first_line] = Enum.take(stream, 1)
    plateau = MarsExploration.process_plateau_definition(first_line)

    stream
    |> Stream.chunk_every(2)
    |> Stream.each(fn [first_line, second_line] ->
      simulate_probe(plateau, first_line, second_line)
      |> IO.puts()
    end)
    |> Stream.run()
  end

  def simulate_probe(plateau = %Plateau{}, first_line, second_line)
      when is_binary(first_line) and is_binary(second_line) do
    MarsExploration.parse_probe(first_line, plateau)
    |> MarsExploration.applying_commands(Parser.parse_commands(second_line))
  end
end
