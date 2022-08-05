import options
import os
import parseutils
import random
import sugar
import tables

type Element = object
    key: int
    value: int

proc tableWay(homeTable: var Table[int, int], inboundSeq: seq[Element]) =
    var inboundTable: Table[int, Element] = initTable[int, Element]()
    for i in inboundSeq:
        inboundTable[i.key] = i
    for key in homeTable.keys():
        if inboundTable.hasKey(key):
            homeTable[key] = inboundTable[key].value

proc seqWay(homeTable: var Table[int, int], inboundSeq: seq[Element]) =
    var mutatableInboundSeq: seq[Element] = inboundSeq
    for key in homeTable.keys():
        for index in 0..mutatableInboundSeq.len - 1:
            if key == mutatableInboundSeq[index].key:
                homeTable[key] = mutatableInboundSeq[index].value
                mutatableInboundSeq.del(index)
                break

when isMainModule:
    randomize()
    var
        max: int
        op: char
    discard parseInt(paramStr(2), max)
    discard parseChar(paramStr(1), op)
    var
        homeTable: Table[int, int] = toTable(collect(for n in 0..max: (rand(max), 0)))
        inboundSeq: seq[Element] = collect(for n in 0..max: Element(key: rand(max), value: rand(max)))
    case op
    of 's':
        seqWay(homeTable, inboundSeq)
    of 't':
        tableWay(homeTable, inboundSeq)
    else:
        echo "Unknown op"
