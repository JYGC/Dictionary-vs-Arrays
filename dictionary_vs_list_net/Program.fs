﻿open System

type Element = struct
    val Key: int
    val Value: int

    new (key: int, value: int) =
        {Key = key; Value = value;}
end

let rec getListElementIndex(inboundList: Element list, pointer: int, key: int): int =
    let element = inboundList.[pointer]

    let nextPointer = pointer + 1
    if key = element.Key then
        pointer
    elif nextPointer < inboundList.Length then
        getListElementIndex(inboundList, nextPointer, key)
    else
        -1

let listWay(homeDict: Map<int, int>, inboundList: Element list): Map<int, int> =
    homeDict |> Map.map(fun key value ->
        let index = getListElementIndex (inboundList, 0, key)
        match index with
        | -1 -> value
        | _ -> inboundList.[index].Value)

let dictWay(homeDict: Map<int, int>, inboundList: Element list): Map<int, int> =
    let inboundDict = inboundList |> List.map(fun element ->
        element.Key, element) |> Map.ofList
    homeDict |> Map.map(fun key value ->
        if inboundDict |> Map.containsKey key then
            inboundDict.[key].Value
        else
            value)

[<EntryPoint>]
let main(args: string[]): int = 
    let max = args.[1] |> int

    let random = Random()
    let homeDict =
        seq {for key in 1 .. max do yield key} |>
                    Seq.sortBy(fun _ -> random.Next(max)) |>
                    Seq.map(fun key -> key, 0) |>
                    Map.ofSeq
    let inboundList =
        seq {for key in 1 .. max do yield key} |>
                    Seq.sortBy(fun _ -> random.Next(max)) |>
                    Seq.map(fun key -> new Element(key, random.Next())) |>
                    List.ofSeq
    let op = args.[0] |> string
    match op with
    | "l" -> Console.WriteLine(listWay(homeDict, inboundList))
    | "d" -> Console.WriteLine(dictWay(homeDict, inboundList))
    | _ -> Console.WriteLine("unknown")
    0