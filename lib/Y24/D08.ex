defmodule Y24.D08 do
  import Adventofcode
  import Enum
  require Vec

  def parse(s), do: lines(s) |> Vec.from_list(2)

  def solve(s, f_vabd) do
    v = parse(s)

    Vec.each(v)
    |> group_by(&Vec.at(v, &1))
    |> Map.delete(hd(~c"."))
    |> Map.values()
    |> map(fn ps -> for a <- ps, b <- ps, a != b, d = Vec.p_sub(a, b), do: f_vabd.(v, a, b, d) end)
    |> List.flatten()
    |> filter(&Vec.member?(v, &1))
    |> uniq()
    |> count()
  end

  def solve1(s), do: solve(s, fn _, a, b, d -> [Vec.p_add(a, d), Vec.p_sub(b, d)] end)

  def solve2(s) do
    solve(s, fn v, a, b, d ->
      as = take_while(Stream.iterate(a, &Vec.p_sub(&1, d)), &Vec.member?(v, &1))
      bs = take_while(Stream.iterate(b, &Vec.p_add(&1, d)), &Vec.member?(v, &1))
      as ++ bs
    end)
  end
end
