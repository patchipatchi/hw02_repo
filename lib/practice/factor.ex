defmodule Practice.Factor do

  def factor(x) do
    can_we_factor(x, 2)
  end

  def can_we_factor(x, n) do
      if n <= x do
        if rem(x, n) == 0 do
          [n] ++ factor(trunc(x/n))
        else
          can_we_factor(x, n + 1)
        end
      else
        []
      end
  end

end

