defmodule Y24.D07 do
  import Adventofcode
  import Enum

  def parse(s), do: lines(s) |> map(&Regex.scan(~r/\d+/u, &1)) |> mmap(&to_integer(hd(&1)))

  def variations(f, [x | ys]), do: variations(f, [x], ys)
  def variations(_, xs, []), do: xs
  def variations(f, xs, [y | ys]), do: variations(f, flat_map(xs, &f.(&1, y)), ys)

  def solve(s, f) do
    sum(map(parse(s), fn [r | xs] -> (member?(variations(f, xs), r) && r) || 0 end))
  end

  def solve1(s), do: solve(s, &[&1 + &2, &1 * &2])
  def solve2(s), do: solve(s, &[&1 + &2, &1 * &2, Integer.undigits(Integer.digits(&1) ++ Integer.digits(&2))])
end
