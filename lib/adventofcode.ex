defmodule Adventofcode do
  use Application
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
  def empty?(s), do: s == ""

  def lines(s) do
    xs = String.split(s, ~r/\R/) |> reverse
    reverse(if hd(xs) == "", do: tl(xs), else: xs)
  end

  def words(s), do: String.split(s, ~r/\s+/, trim: true)
  def unpipe(s), do: String.split(s, ~r/\|/, trim: true)
  def uncsv(s), do: String.split(s, ~r/\,/, trim: true)

  # collections
  def concat_binaries(xs), do: Enum.reduce(xs, &(&2 <> &1))

  # TODO find a better way to re-export
  defdelegate to_integer(x), to: String

  defdelegate any?(xs, f), to: Enum
  defdelegate all?(xs, f), to: Enum
  defdelegate member?(xs, x), to: Enum
  defdelegate map(xs, f), to: Enum
  defdelegate filter(xs, f), to: Enum
  defdelegate count(xs, f), to: Enum
  defdelegate chunk_by(xs, f), to: Enum

  defdelegate reduce(xs, a, f), to: Enum

  defdelegate at(xs, n), to: Enum
  defdelegate take(xs, n), to: Enum
  defdelegate drop(xs, n), to: Enum
  defdelegate concat(xs, ys), to: Enum

  defdelegate zip_with(xs, f), to: Enum
  defdelegate zip(xs, ys), to: Enum
  defdelegate unzip(xs), to: Enum

  defdelegate sort(xs), to: Enum
  defdelegate sort(xs, f), to: Enum
  defdelegate reverse(xs), to: Enum
  defdelegate frequencies(xs), to: Enum
  defdelegate count(xs), to: Enum
  defdelegate sum(xs), to: Enum

  defdelegate chunk_every(xs, count, step, leftover), to: Enum

  defdelegate cycle(xs), to: Stream

  # (a -> b) -> f (g a) -> f (g b)
  def mmap(xs, f), do: map(xs, fn x -> map(x, f) end)
  # TODO find flip
  def app(args, f), do: apply(f, args)

  # NOTE very slow
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

    # https://github.com/parroty/exprof?tab=readme-ov-file#usage
    # profile do
    #   run("Y24.D06")
    # end
  end
end
