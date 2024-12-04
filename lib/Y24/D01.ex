defmodule Y24.D01 do
  import Adventofcode

  # string -> {[int], [int]}
  def parse(s) do
    lines(s)
    |> map(&words/1)
    |> mmap(&String.to_integer/1)
    |> map(&List.to_tuple/1)
    |> unzip()
  end

  # string -> int
  def solve1(s) do
    parse(s)
    |> Tuple.to_list()
    |> map(&sort/1)
    |> zip_with(fn [x, y] -> abs(x - y) end)
    |> sum()
  end

  # string -> int
  def solve2(s) do
    {xs, ys} = parse(s)
    x2c = frequencies(ys)

    map(xs, &(&1 * Map.get(x2c, &1, 0)))
    |> sum()
  end
end
