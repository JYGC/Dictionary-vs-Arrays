#!/bin/env python3
import random
import sys

class Element:
    def __init__(self, key, value):
        self.key = key
        self.value = value

def dict_way(home_dict, inbound_arr):
    inbound_dict = {}
    for i in inbound_arr:
        inbound_dict[i.key] = i
    for k in home_dict:
        if k in inbound_dict:
            home_dict[k] = inbound_dict[k].value

def list_way(home_dict, inbound_arr):
    for k in home_dict:
        for i in inbound_arr:
            if k == i.key:
                home_dict[k] = i.value
                inbound_arr.remove(i)
                break


if __name__ == '__main__':
    max = int(sys.argv[2])
    home_dict = {random.randint(0, max):None for n in range(0,max)}
    inbound_arr = [Element(random.randint(0, max), random.randint(0, max)) for n in range(0,max)]
    op = sys.argv[1]
    if op == 'l':
        list_way(home_dict, inbound_arr)
    elif op == 'd':
        dict_way(home_dict, inbound_arr)
    else:
        print("Unknown op")

