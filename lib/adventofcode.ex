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
    module = String.to_existing_atom("Elixir.#{yxxdxx}")

    case Code.ensure_compiled(module) do
      {:module, _} -> :ok
      {:error, e} -> raise("Can't find module #{yxxdxx}: #{inspect(e)}")
    end

    solve1 = Function.capture(module, String.to_existing_atom("solve1"), 1)
    solve2 = Function.capture(module, String.to_existing_atom("solve2"), 1)
    IO.puts("#{yxxdxx} #{to_string(solve1.(input))} #{to_string(solve2.(input))}")
  end

  def lines(s), do: String.split(s, ~r/\R/, trim: true)
  def words(s), do: String.split(s, ~r/\s+/, trim: true)

  # TODO find a better way to re-export
  defdelegate any?(xs, f), to: Enum
  defdelegate all?(xs, f), to: Enum
  defdelegate member?(xs, f), to: Enum
  defdelegate map(xs, f), to: Enum
  defdelegate filter(xs, f), to: Enum
  defdelegate count(xs, f), to: Enum

  defdelegate take(xs, n), to: Enum
  defdelegate drop(xs, n), to: Enum
  defdelegate concat(xs, ys), to: Enum

  defdelegate zip_with(xs, f), to: Enum
  defdelegate zip(xs, ys), to: Enum
  defdelegate unzip(xs), to: Enum

  defdelegate sort(xs), to: Enum
  defdelegate frequencies(xs), to: Enum
  defdelegate sum(xs), to: Enum

  defdelegate chunk_every(xs, count, step, leftover), to: Enum

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
    run("Y24.D02")
  end
end
