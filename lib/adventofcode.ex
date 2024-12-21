defmodule Adventofcode do
  use Application
  import Enum
  # import ExProf.Macro

  def start(_type, _args) do
    {:ok, pid} = Task.start(fn -> main([]) end)
    ref = Process.monitor(pid)

    receive do
      {:DOWN, ^ref, _, _, _} -> IO.puts("Done.")
    end

    {:ok, pid}
  end

  # strings
  def empty_string?(s), do: s == ""
  defdelegate to_integer(x), to: String

  def lines(s) do
    xs = String.split(s, ~r/\R/) |> reverse
    reverse(if hd(xs) == "", do: tl(xs), else: xs)
  end

  def words(s), do: String.split(s, ~r/\s+/, trim: true)
  def unpipe(s), do: String.split(s, ~r/\|/, trim: true)
  def uncsv(s), do: String.split(s, ~r/\,/, trim: true)

  # collections
  def concat_binaries(xs), do: Enum.reduce(xs, &(&2 <> &1))

  # (a -> b) -> f (g a) -> f (g b)
  def mmap(xs, f), do: map(xs, fn x -> map(x, f) end)
  # TODO find flip
  def app(args, f), do: apply(f, args)

  # NOTE very slow
  defdelegate cycle(xs), to: Stream
  def stream_head(xs), do: hd(take(xs, 1))
  def stream_tail(xs), do: Stream.drop(xs, 1)

  # combinatorics
  # pairs([1, 2, 3, 4]) => [{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}]
  def pairs(xs) do
    case xs do
      [] -> []
      [x | xs] -> for(y <- xs, do: {x, y}) ++ pairs(xs)
    end
  end

  # days
  def readInput(yxxdxx) do
    {:ok, input} = File.read("res/" <> String.replace(yxxdxx, ".", "/") <> ".txt")
    input
  end

  def run(yxxdxx) do
    input = readInput(yxxdxx)
    module = String.to_existing_atom("Elixir.#{yxxdxx}")

    case Code.ensure_compiled(module) do
      {:module, _} -> :ok
      {:error, e} -> raise("Can't find module #{yxxdxx}: #{inspect(e)}")
    end

    solve1 = Function.capture(module, String.to_existing_atom("solve1"), 1)
    solve2 = Function.capture(module, String.to_existing_atom("solve2"), 1)
    IO.puts("#{yxxdxx} #{to_string(solve1.(input))} #{to_string(solve2.(input))}")
  end

  def main(_args) do
    run("Y24.D01")
    run("Y24.D02")
    run("Y24.D03")
    run("Y24.D04")
    run("Y24.D05")
    run("Y24.D06")
    run("Y24.D07")

    # https://github.com/parroty/exprof?tab=readme-ov-file#usage
    # profile do
    #   run("Y24.D06")
    # end
  end
end
