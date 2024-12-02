defmodule Adventofcode do
  use Application

  def start(_type, _args) do
    {:ok, pid} = Task.start(fn -> main([]) end)
    ref = Process.monitor(pid)

    receive do
      {:DOWN, ^ref, _, _, _} -> IO.puts("Done.")
    end

    {:ok, pid}
  end

  def run(yxxdxx) do
    input = readInput(yxxdxx)

    IO.puts(
      yxxdxx <>
        " " <>
        to_string(Y24.D01.solve1(input)) <>
        " " <>
        to_string(Y24.D01.solve2(input)) <>
        "\n"
    )
  end

  def lines(s), do: String.split(s, ~r/\R/, trim: true)
  def words(s), do: String.split(s, ~r/\s+/, trim: true)

  # TODO find a way to re-export
  def map(xs, f), do: Enum.map(xs, f)
  def sort(xs), do: Enum.sort(xs)
  def zip(xs, ys), do: Enum.zip(xs, ys)

  # (a -> b) -> f (g a) -> f (g b)
  def mmap(xs, f), do: Enum.map(xs, fn x -> Enum.map(x, f) end)
  # TODO find flip
  def app(args, f), do: apply(f, args)

  def readInput(yxxdxx) do
    {:ok, input} = File.read("res/" <> String.replace(yxxdxx, ".", "/") <> ".txt")
    input
  end

  def main(_args) do
    run("Y24.D01")
  end
end
