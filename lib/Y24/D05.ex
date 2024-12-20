defmodule Y24.D05 do
  import Adventofcode

  def parse(s) do
    [abs, [""], xss] = lines(s) |> chunk_by(&empty?/1)

    {abs |> map(&unpipe/1) |> mmap(&to_integer/1) |> MapSet.new(fn [a, b] -> {b, a} end),
     xss |> map(&uncsv/1) |> mmap(&to_integer/1)}
  end

  def correct?(bas, xs), do: !any?(pairs(xs), &MapSet.member?(bas, &1))
  def at_mid(xs), do: at(xs, floor(length(xs) / 2))
  def correct(bas, xs), do: sort(xs, fn a, b -> MapSet.member?(bas, {a, b}) end)

  def solve1(s) do
    {bas, xss} = parse(s)

    xss
    |> filter(&correct?(bas, &1))
    |> map(&at_mid/1)
    |> sum
  end

  def solve2(s) do
    {bas, xss} = parse(s)

    xss
    |> filter(&(!correct?(bas, &1)))
    |> map(&correct(bas, &1))
    |> map(&at_mid/1)
    |> sum
  end
end
