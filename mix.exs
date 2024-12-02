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
      escript: [main_module: Adventofcode, name: "run"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Adventofcode, []},
      extra_applications: [:logger],
      ansi_enabled: true
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:quark, "~> 2.3"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
