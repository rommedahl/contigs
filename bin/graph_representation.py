import sys
import numpy as np
import bokeh.plotting as bp

class BranchPoint:
    def __init__(self, vertex, predecessor_bp=None, distance_to_source=0):
        self.__vertex = vertex
        self.__distance_to_source = distance_to_source
        self.__predecessor_bp = predecessor_bp
        self.__successors = []

    def add_successor(self, new_successor):
        self.__successors += [new_successor]

    def get_vertex(self):
        return self.__vertex

    def get_successors_bp(self):
        return self.__successors

    def get_predecessor_bp(self):
        return self.__predecessor_bp

    def get_distance_to_source(self):
        return self.__distance_to_source


class BreadthFirstSearchTree:
    def __init__(self, source_vertex):
        """source is the source vertex"""
        self.__source = BranchPoint(source_vertex)
        self.__branch_point_list = []
        self.__branch_point_list += [self.__source]

    def insert(self, vertex, predecessor_branch_point=None, distance_to_source=0, with_return=False):
        new_branch_point = BranchPoint(vertex, predecessor_branch_point, distance_to_source)
        predecessor_branch_point.add_successor(new_branch_point)
        self.__branch_point_list += [new_branch_point]
        if with_return:
            return new_branch_point

    def get_source_branch_point(self):
        return self.__source

    def __iter__(self):
        return self.__iterator(self.__source)

    def __iterator(self, branch_point):
        yield branch_point
        for successor in branch_point.get_successors_bp():
                for successor_successor in self.__iterator(successor):
                    yield successor_successor


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
        for key in graph_dictionary.keys():
            vertex = Vertex(key)
            self.vertex_dictionary[key] = vertex
        for key in graph_dictionary.keys():
            key_vertex = self.vertex_dictionary[key]
            for value in graph_dictionary[key]:
                value_vertex = self.vertex_dictionary[value]
                key_vertex.add_neighbour(value_vertex)

    def __iter__(self):
        return self.__yielder()

    def __yielder(self):
        for key in self.vertex_dictionary.keys():
            yield key

    @classmethod
    def __breadth_first_search(cls, source_vertex):
        source_vertex.set_color('gray')
        the_tree = BreadthFirstSearchTree(source_vertex)
        queue = []
        queue += [the_tree.get_source_branch_point()]
        while queue:
            branch_point = queue.pop()
            vertex = branch_point.get_vertex()
            for neighbour in vertex.get_neighbours():
                if neighbour.get_color() is 'white':
                    neighbour.set_color('gray')
                    distance_to_source = branch_point.get_distance_to_source() + 1
                    neighbour_branch_point = the_tree.insert(neighbour, branch_point, distance_to_source, with_return=True)
                    queue += [neighbour_branch_point]
            vertex.set_color('black')
        return the_tree


if __name__ == '__main__': #ensures that the main run isn't run when this file is importet
    data_line_list = []
    graph_dictionary = {}

    with open('Spruce_fingerprint_2017-03-10_16.48.olp.m4') as data:
        for i in range(10):
            data_line_list = data.readline().replace('\n', '').split('\t')
            if data_line_list[0] not in graph_dictionary.keys():
                graph_dictionary[data_line_list[0]] = {data_line_list[1]}
            else:
                graph_dictionary[data_line_list[0]] |= {data_line_list[1]}
            if data_line_list[1] not in graph_dictionary.keys():
                graph_dictionary[data_line_list[1]] = {data_line_list[0]}
            else:
                graph_dictionary[data_line_list[1]] |= {data_line_list[0]}


    graph = Graph(graph_dictionary)

    for key in graph:
        print('in graph', key)
