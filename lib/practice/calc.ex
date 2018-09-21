defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def split_ops(expr, op) do
    expr
    |> String.split(op)
    |> Enum.join(" " <> op <> " ")
  end

  def handle_negative_first(list) do
    if List.first(list) == "" do
      [Float.to_string(parse_float(Enum.at(list, 2)) * -1)]++Enum.drop(list, 3)
    else
      list
    end
  end

  def calc(expr) do
    expr
    |> String.replace(~r/\s/, "")
    |> split_ops("+")
    |> split_ops("-")
    |> split_ops("*")
    |> split_ops("/")
    |> String.split(" ")
    |> handle_negative_first()
    |> shunting_yard([], [])
    |> postfix_eval([])
    |> List.first()
    |> parse_float()
  end

  def do_op(op, s) do
    case op do
      "+" -> [Float.to_string(parse_float(Enum.at(s, 1)) + parse_float(Enum.at(s, 0)))]++Enum.drop(s, 2)
      "-" -> [Float.to_string(parse_float(Enum.at(s, 1)) - parse_float(Enum.at(s, 0)))]++Enum.drop(s, 2)
      "*" -> [Float.to_string(parse_float(Enum.at(s, 1)) * parse_float(Enum.at(s, 0)))]++Enum.drop(s, 2)
      "/" -> [Float.to_string(parse_float(Enum.at(s, 1)) / parse_float(Enum.at(s, 0)))]++Enum.drop(s, 2)
    end
  end

  def postfix_eval(list, s) do
    ops = %{"+" => 1, "-" => 1, "*" => 2, "/" => 2}
    if list == [] do
      s
    else
      if Map.get(ops, List.first(list)) == nil do
        postfix_eval(Enum.drop(list, 1), [List.first(list)]++s)
      else
        postfix_eval(Enum.drop(list, 1), do_op(List.first(list), s))
      end
    end
  end

  def shunting_yard(list, q, s) do
    ops = %{"+" => 1, "-" => 1, "*" => 2, "/" => 2}
    if list == [] do
      if s == [] do
        q
      else
        shunting_yard(list, q++[List.first(s)], Enum.drop(s, 1))
      end
    else
      if Map.get(ops, List.first(list)) == nil do
        shunting_yard(Enum.drop(list, 1), q++[List.first(list)], s)
      else
        if s == [] do
          shunting_yard(Enum.drop(list, 1), q, [List.first(list)]++s)
        else
          if Map.get(ops, List.first(list)) > Map.get(ops, List.first(s)) do
            shunting_yard(Enum.drop(list, 1), q, [List.first(list)]++s)
          else
            shunting_yard(list, q++[List.first(s)], Enum.drop(s, 1))
          end
        end
      end
    end
  end

end

