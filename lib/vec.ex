defmodule Vec do
  import Adventofcode

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

  defmacro dirs8, do: udlr() ++ diags()

  # TODO make multidim
  defstruct dims: {0, 0}, binary: []

  def from_list(xs, 2) do
    %Vec{
      dims: {count(xs), xs |> Enum.at(0) |> String.length()},
      binary: concat_binaries(xs)
    }
  end

  def to_list(%Vec{dims: {ym, xm}, binary: binary}) do
    for y <- 0..(ym - 1), do: :binary.part(binary, y * xm, xm)
  end

  def at(%Vec{dims: {ym, xm}, binary: binary}, {y, x}, default \\ nil) do
    if y < 0 || y >= ym || x < 0 || x >= xm do
      default
    else
      :binary.at(binary, y * xm + x)
    end
  end

  def dim_mappend({y1, x1}, {y2, x2}), do: {y1 + y2, x1 + x2}
end
