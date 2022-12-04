solution_pt1 = Enum.count(
                Enum.to_list(
                  "input.txt" 
                  |> File.stream!()
                  |> Stream.map(fn line -> String.trim(line) end) 
                  |> Stream.map(fn line -> String.split(line, ",") end)
                  |> Stream.filter(fn x ->
                        first_guy = String.split(Enum.at(x, 0), "-")
                        second_guy = String.split(Enum.at(x, 1), "-")

                        first_guy_x1 = Enum.at(first_guy, 0) |> String.to_integer()
                        first_guy_x2 = Enum.at(first_guy, 1) |> String.to_integer()
                        second_guy_x1 = Enum.at(second_guy, 0) |> String.to_integer()
                        second_guy_x2 = Enum.at(second_guy, 1) |> String.to_integer()

                        cond do
                          first_guy_x1 >= second_guy_x1 and first_guy_x2 <= second_guy_x2 -> true
                          second_guy_x1 >= first_guy_x1 and second_guy_x2 <= first_guy_x2 -> true
                          true -> false
                        end
                  end)
                )
              )

solution_pt2 = Enum.count(
                Enum.to_list(
                  "input.txt" 
                  |> File.stream!()
                  |> Stream.map(fn line -> String.trim(line) end) 
                  |> Stream.map(fn line -> String.split(line, ",") end)
                  |> Stream.filter(fn x ->
                        first_guy = String.split(Enum.at(x, 0), "-")
                        second_guy = String.split(Enum.at(x, 1), "-")

                        first_guy_x1 = Enum.at(first_guy, 0) |> String.to_integer()
                        first_guy_x2 = Enum.at(first_guy, 1) |> String.to_integer()
                        second_guy_x1 = Enum.at(second_guy, 0) |> String.to_integer()
                        second_guy_x2 = Enum.at(second_guy, 1) |> String.to_integer()

                        cond do
                          first_guy_x1 >= second_guy_x1 and first_guy_x1 <= second_guy_x2 -> true
                          first_guy_x2 >= second_guy_x1 and first_guy_x2 <= second_guy_x2 -> true
                          second_guy_x1 >= first_guy_x1 and second_guy_x1 <= first_guy_x2 -> true
                          second_guy_x2 >= first_guy_x1 and second_guy_x2 <= first_guy_x2 -> true
                          true -> false
                        end
                  end)
                )
              )

IO.puts(solution_pt1)
IO.puts(solution_pt2)
