defmodule Obj do
    defstruct key: 0, value: 0
end

defmodule DictVsList.CLI do
    def main(args) do
        max = String.to_integer(args |> Enum.at 1)
        home_dict = Stream.repeatedly(fn -> :rand.uniform(max) end)
          |> Stream.uniq |> Enum.take(max) |> Enum.map(fn n -> {n, nil} end)
          |> Map.new
        inbound_arr = Stream.repeatedly(fn -> %Obj{
            key: :rand.uniform(max),
            value: :rand.uniform(max)
        } end) |> Stream.uniq |> Enum.take(max)
        op = args |> Enum.at 0
        case op do
            "l" ->
                list_way home_dict, inbound_arr
            "d" ->
                dict_way home_dict, inbound_arr
            _ ->
                "Unknown op"
        end
    end

    defp dict_way(home_dict, inbound_arr) do
        inbound_dict = inbound_arr |> Enum.map(fn n -> {n.key, n} end)
          |> Map.new
        home_dict |> Enum.map(fn {key, value} ->
            if Map.has_key?(inbound_dict, key) do
                {key, Map.get(inbound_dict, key).value}
            else
                {key, value}
            end
        end) |> Map.new
    end

    defp list_way(home_dict, inbound_arr) do
        home_dict |> Enum.map(fn {key, value} ->
            index = get_inbound_index(inbound_arr, 0, key)
            if index !== nil do
                {key, Enum.at(inbound_arr, index).value}
            else
                {key, value}
            end
        end) |> Map.new
    end

    defp get_inbound_index(inbound, pointer, key) do
        element = Enum.at(inbound, pointer)
        if key === element.key do
            pointer
        else
            pointer = pointer + 1
            if pointer < Enum.count(inbound) do
                get_inbound_index(inbound, pointer, key)
            else
                nil
            end
        end
    end
end
