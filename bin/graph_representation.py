import sys
import numpy as np
import bokeh.plotting as bp

class Vertex:
    def __init__(self, value):
        self.__value = value
        self.__colour = 'white'
        self.__neighbours = {}
    def set_color(self, colour):
        self.__colour = colour
    def get_value(self):
        return self.__value
    def add_neighbour(self, neighbour):
        self.__neighbours[neighbour.get_value()] = [neighbour]

class Graph:
    def __init__(self, graph_dictionary):
        self.vertex_dictionary = {}
        for key in graph_dictonary.keys():
            vertex = Vertex(key)
            self.vertex_dictionary[key] = vertex
        for key in graph_dictonary.keys():
            key_vertex = self.vertex_dictionary[key]
            for value in graph_dictonary[key]:
                value_vertex = self.vertex_dictionary[value]
                key_vertex.add_neighbour(value_vertex)


if __name__ == '__main__': #ensures that the main run isn't run when this file is importet
    data_line_list = []
    graph_dictonary = {}

    with open('Spruce_fingerprint_2017-03-10_16.48.olp.m4') as data:
        for i in range(10):
            data_line_list = data.readline().replace('\n', '').split('\t')
            c = 0
            if data_line_list[0] not in graph_dictonary.keys():
                graph_dictonary[data_line_list[0]] = {data_line_list[1]}
                c += 1
            else:
                graph_dictonary[data_line_list[0]] |= {data_line_list[1]}
            if data_line_list[1] not in graph_dictonary.keys():
                graph_dictonary[data_line_list[1]] = {data_line_list[0]}
            else:
                graph_dictonary[data_line_list[1]] |= {data_line_list[0]}

    for key in graph_dictonary:
        for value in graph_dictonary[key]:



    print(graph_dictonary)
