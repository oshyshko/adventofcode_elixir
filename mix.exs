defmodule Adventofcode.MixProject do
  use Mix.Project

  def project do
    [
      app: :adventofcode,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      default_task: "run",
      escript: [main_module: Adventofcode, name: "adventofcode"]
    ]
  end

  def application do
    [
      mod: {Adventofcode, []},
      extra_applications: [:logger],
      ansi_enabled: true
    ]
  end

  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
