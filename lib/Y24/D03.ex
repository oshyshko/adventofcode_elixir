defmodule Y24.D03 do
  import Adventofcode
  import Enum

  # string -> [:do | :dont | {:mul, x, y}]
  def parse(s) do
    Regex.scan(~r/(mul)\((\d+),(\d+)\)|do\(\)|don't\(\)/u, s)
    |> map(fn
      [_, "mul", x, y] -> {:mul, to_integer(x), to_integer(y)}
      ["do()"] -> :do
      ["don't()"] -> :dont
    end)
  end

  def eval({:mul, x, y}), do: x * y
  def eval(_), do: 0

  # string -> int
  def solve1(s), do: parse(s) |> map(&eval/1) |> sum

  def solve2(s) do
    do_dont = fn
      :do, {xs, _} -> {xs, :do}
      :dont, {xs, _} -> {xs, :dont}
      {:mul, x, y}, {xs, :do} -> {xs ++ [{:mul, x, y}], :do}
      {:mul, _, _}, s -> s
    end

    parse(s)
    |> reduce({[], :do}, do_dont)
    |> elem(0)
    |> map(&eval/1)
    |> sum
  end
end
