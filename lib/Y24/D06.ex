defmodule Y24.D06 do
  import Adventofcode
  import Enum
  import Vec

  def parse(s) do
    v = Vec.from_list(lines(s), 2)
    {v, {_, _} = Vec.match(v, "^")}
  end

  def next_d(d) do
    case(d) do
      u() -> r()
      r() -> d()
      d() -> l()
      l() -> u()
    end
  end

  def traverse(at, p), do: traverse(at, p, u(), MapSet.new([{p, u()}]))

  def traverse(at, p, d, ps) do
    p_new = Vec.dim_mappend(p, d)
    x = at.(p_new)

    cond do
      x == nil -> ps |> map(fn {p, _} -> p end) |> MapSet.new()
      MapSet.member?(ps, {p_new, d}) -> :loop
      x in ~c"#" -> traverse(at, p, next_d(d), ps)
      x in ~c".^" -> traverse(at, p_new, d, MapSet.put(ps, {p_new, d}))
    end
  end

  def solve1(s) do
    {v, p} = parse(s)
    count(traverse(&Vec.at(v, &1), p))
  end

  def solve2(s) do
    {v, p} = parse(s)

    sum(
      for obstacle <- traverse(&Vec.at(v, &1), p) do
        at = &((&1 == obstacle && hd(~c"#")) || Vec.at(v, &1))

        (:loop == traverse(at, p) && 1) || 0
      end
    )
  end
end
