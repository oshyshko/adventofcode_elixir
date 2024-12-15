defmodule Y24.D04 do
  import Adventofcode
  require Vec

  def parse(s), do: Vec.from_list(lines(s), 2)

  def contains_trace(v, p, d, what), do: contains_trace1(v, p, d, what, 0, byte_size(what))

  def contains_trace1(v, p, d, what, i, n) do
    cond do
      i == n -> true
      Vec.at(v, p) == :binary.at(what, i) -> contains_trace1(v, Vec.dim_mappend(p, d), d, what, i + 1, n)
      true -> false
    end
  end

  # string -> int
  def solve1(s) do
    %Vec{dims: {ym, xm}} = v = parse(s)

    sum(
      for y <- 0..(ym - 1),
          x <- 0..(xm - 1),
          d <- Vec.dirs8(),
          contains_trace(v, {y, x}, d, "XMAS") do
        1
      end
    )
  end

  def solve2(s) do
    %Vec{dims: {ym, xm}} = v = parse(s)

    sum(
      for y <- 1..(ym - 2),
          x <- 1..(xm - 2) do
        p = {y, x}
        is_a = Vec.at(v, p) == 65

        is_mmss =
          member?(
            [~c"MMSS", ~c"MSMS", ~c"SMSM", ~c"SSMM"],
            for(d <- Vec.diags(), do: Vec.at(v, Vec.dim_mappend(p, d)))
          )

        (is_a && is_mmss && 1) || 0
      end
    )
  end
end
