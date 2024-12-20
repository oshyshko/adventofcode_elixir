defmodule Y24.D06 do
  import Adventofcode
  import Vec

  def dirs, do: cycle([u(), r(), d(), l()])

  def parse(s) do
    v = Vec.from_list(lines(s), 2)
    {v, {_, _} = Vec.match(v, "^")}
  end

  def traverse(at, p) do
    d = stream_head(dirs())
    traverse(at, p, d, stream_tail(dirs()), MapSet.new([{p, d}]))
  end

  def traverse(at, p, d, ds, ps) do
    p_new = Vec.dim_mappend(p, d)
    x = at.(p_new)

    cond do
      x == nil -> ps |> map(fn {p, _} -> p end) |> MapSet.new()
      MapSet.member?(ps, {p_new, d}) -> :loop
      x in ~c"#" -> traverse(at, p, stream_head(ds), stream_tail(ds), ps)
      x in ~c".^" -> traverse(at, p_new, d, ds, MapSet.put(ps, {p_new, d}))
    end
  end

  def solve1(s) do
    {v, p} = parse(s)
    at = &Vec.at(v, &1)
    count(traverse(at, p))
  end

  def solve2(s) do
    {v, p} = parse(s)
    visited = traverse(&Vec.at(v, &1), p)
    hash = hd(~c"#")

    sum(
      for obstacle <- visited do
        at = &((&1 == obstacle && hash) || Vec.at(v, &1))

        (traverse(at, p) == :loop && 1) || 0
      end
    )
  end
end
