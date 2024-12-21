defmodule Vec do
  require Enum

  defmacro u, do: {-1, 0}
  defmacro d, do: {1, 0}
  defmacro l, do: {0, -1}
  defmacro r, do: {0, 1}
  defmacro udlr, do: [u(), d(), l(), r()]

  defmacro ul, do: {-1, -1}
  defmacro ur, do: {-1, 1}
  defmacro dl, do: {1, -1}
  defmacro dr, do: {1, 1}
  defmacro diags, do: [ul(), ur(), dl(), dr()]

  defmacro udlr_diags, do: udlr() ++ diags()

  # TODO make multidim
  defstruct dims: {0, 0}, binary: []

  def from_list(xs, 2) do
    %Vec{
      dims: {Enum.count(xs), xs |> Enum.at(0) |> String.length()},
      binary: Enum.reduce(xs, &(&2 <> &1))
    }
  end

  def to_list(%Vec{dims: {ym, xm}, binary: binary}) do
    for y <- 0..(ym - 1), do: :binary.part(binary, y * xm, xm)
  end

  def member?(%Vec{dims: {ym, xm}}, {y, x}), do: y >= 0 && y < ym && x >= 0 && x < xm

  def at(v = %Vec{dims: {_, xm}, binary: binary}, yx = {y, x}, default \\ nil) do
    (member?(v, yx) && :binary.at(binary, y * xm + x)) || default
  end

  def each(%Vec{dims: {ym, xm}}), do: for(y <- 0..(ym - 1), x <- 0..(xm - 1), do: {y, x})

  def match(%Vec{dims: {_ym, xm}, binary: binary}, x) do
    case :binary.match(binary, [x]) do
      :nomatch -> :nomatch
      {i, _} -> {div(i, xm), rem(i, xm)}
    end
  end

  def p_neg({y, x}), do: {-y, -x}
  def p_add({y1, x1}, {y2, x2}), do: {y1 + y2, x1 + x2}
  def p_sub({y1, x1}, {y2, x2}), do: {y1 - y2, x1 - x2}
end
