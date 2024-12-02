defmodule Y24.D01 do
  import Adventofcode

  # string -> {xs, ys}
  def parse(s) do
    lines(s)
    |> map(&words/1)
    |> mmap(&String.to_integer/1)
    |> map(&List.to_tuple/1)
    |> Enum.unzip()
  end

  # string -> int
  def solve1(s) do
    parse(s)
    |> Tuple.to_list()
    |> map(&Enum.sort/1)
    |> Enum.zip_with(fn [x, y] -> abs(x - y) end)
    |> Enum.sum()
  end

  # string -> int
  def solve2(s) do
    {xs, ys} = parse(s)
    x2c = Enum.frequencies(ys)

    map(xs, &(&1 * Map.get(x2c, &1, 0)))
    |> Enum.sum()
  end
end
