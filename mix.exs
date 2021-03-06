defmodule ExploringMars.MixProject do
  use Mix.Project

  def project do
    [
      app: :exploring_mars,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
      deps: deps()
    ]
  end

  defp escript_config do
    [
      main_module: ExploringMars.CLI,
      comment: "Exploring Mars"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
