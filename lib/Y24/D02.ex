defmodule Y24.D02 do
  import Adventofcode

  # string -> [[int]]
  def parse(s) do
    lines(s)
    |> map(&words/1)
    |> mmap(&String.to_integer/1)
  end

  def safe?(xs) do
    xs = chunk_every(xs, 2, 1, :discard) |> map(fn [x, y] -> y - x end)

    all?(xs, &member?([1, 2, 3], &1)) || all?(xs, &member?([-1, -2, -3], &1))
  end

  # string -> ([int] -> [[int]]) -> int
  def solve(s, explode) do
    parse(s)
    |> Enum.map(explode)
    |> filter(fn xs -> any?(xs, &safe?/1) end)
    |> length
  end

  # string -> int
  def solve1(s), do: solve(s, fn xs -> [xs] end)
  def solve2(s), do: solve(s, &for(i <- 0..(length(&1) - 1), do: concat(take(&1, i), drop(&1, i + 1))))
end
