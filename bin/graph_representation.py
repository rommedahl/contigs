import sys
import numpy as np


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
    def __init__(self, key):
        self.__key = key
        self.__color = 'white'
        self.__neighbours = {}

    def set_color(self, colour):
        self.__color = colour

    def get_key(self):
        return self.__key

    def get_color(self):
        return self.__color

    def add_neighbour(self, neighbour):
        self.__neighbours[neighbour.get_key()] = [neighbour]
        #for values in self.__neighbours.values():
        #    print('{} has neighbours {}'.format(neighbour.get_key(), values[0].get_key()))

    def get_neighbours(self):
        neighbour_list = []
        for key in self.__neighbours.keys():
            neighbour_list += [self.__neighbours[key][0]]
        return neighbour_list


class Graph:
    """Graph creates a graph object from a graph dictionary of the form graph_dictionary[vertex_key] = {neighbour1_key, 
    n2_key, ...} where key is an immutable value, unique for every vertex"""
    def __init__(self, graph_dictionary):
        self.vertex_dictionary = {}
        self.__component_trees = []
        self.components_dictionary = {}
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

    def bfs(self, vertex_key):
        source = self.vertex_dictionary[vertex_key]
        return self.__breadth_first_search(source)

    def color_reset(self):
        for vertex in self.vertex_dictionary.values():
            vertex.set_color('white')

    def create_subgraph_dict(self):
        """Uses bfs to create a dictionary of the form 
        self.components_dictionary[index] = list_of_keys_in_same_component"""
        if not self.__component_trees:
            self.compartmentalize()
        component_trees = self.get_component_trees()
        component_list_of_lists = []
        for tree in component_trees:
            tree_list = []
            for branchpoint in tree:
                tree_list += [branchpoint.get_vertex().get_key()]
            component_list_of_lists += [tree_list]
        counter = 0
        for list in component_list_of_lists:
            self.components_dictionary[counter] = list
            counter += 1

    def get_component_trees(self):
        return self.__component_trees

    def get_component_dictionary(self):
        return self.components_dictionary

    def compartmentalize(self):
        """"Creates a list of breadth_first_search_tree_objects, one for each component of the graph object"""
        self.color_reset()
        for vertex in self.vertex_dictionary.values():
            if vertex.get_color() != 'black':
                bfs_tree = self.__breadth_first_search(vertex)
                self.__component_trees += [bfs_tree]

    def component_diameter(self, component_tree, k=5):
        '''
        finds the diameter of a bfs_tree, probabilistic with k tries
        :param component_tree: bfs_tree
        :param k: amount of times to search the tree
        :return: diameter, diameter path = [key1, key2, ... ]
        '''
        max_distance = 0
        furthest_branch = component_tree.get_source_branch_point()
        for i in range(k):
            furthest_in_tree = 0
            for branch_point in component_tree:
                distance = branch_point.get_distance_to_source()
                if distance > max_distance:
                    max_distance = distance
                if distance > furthest_in_tree:
                    furthest_in_tree = distance
                    furthest_branch = branch_point
            component_tree = self.__breadth_first_search(furthest_branch.get_vertex())
            self.color_reset()
        path = []
        while furthest_branch:
            path.append(furthest_branch.get_vertex().get_key())
            furthest_branch = furthest_branch.get_predecessor_bp()
        diameter = max_distance
        return diameter, path

    def write_diameter_path_to_file(self):
        n = 0
        for tree in self.__component_trees:
            n += 1
            d, path = self.component_diameter(tree)
            filename = 'partition'+ str(n)+'.txt'
            file = open(filename, 'w')
            file.write(str(d+1)+'\n')
            for vertex in path:
                file.write(vertex+'\n')


    @classmethod
    def __breadth_first_search(cls, source_vertex):
        """A breadth first search algorithm, returning a breadth_first_search_tree_object"""
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


def graph_dictionary_creator(file, n_o_lines=None):
    """Creates a graph dictionary of the form graph_dictionary[vertex_key] = {neighbour1_key, 
    n2_key, ...} where key is an immutable value, unique for every vertex"""
    graph_dictionary = {}
    line_list = []
    if not n_o_lines:
        for line in file:
            line_list = file.readline().replace('\n', '').split('\t')
            if len(line_list) > 1:
                line_list_to_dict(line_list, graph_dictionary)
            else:
                print('line list: {}\nhas too few elements'.format(line_list))
    else:
        for i in range(n_o_lines):
            line_list = file.readline().replace('\n', '').split('\t')
            if len(line_list) > 1:
                line_list_to_dict(line_list, graph_dictionary)
            else:
                print('line list: {}\nhas too few elements'.format(line_list))
    return graph_dictionary

def line_list_to_dict(line_list, graph_dictionary):
    """Takes a line from the file split by ' ' and turned int a list and adds it to the graph dictionary"""
    if line_list[0] not in graph_dictionary.keys():
        graph_dictionary[line_list[0]] = {line_list[1]}
    else:
        graph_dictionary[line_list[0]] |= {line_list[1]}
    if line_list[1] not in graph_dictionary.keys():
        graph_dictionary[line_list[1]] = {line_list[0]}
    else:
        graph_dictionary[line_list[1]] |= {line_list[0]}

if __name__ == '__main__': #ensures that the main run isn't run when this file is importet
    sys.setrecursionlimit(10000)
    argument_list = sys.argv

    if argument_list[-1] == '-stdin':
        try:
            with sys.stdin as file:
                graph_dictionary = graph_dictionary_creator(file, int(argument_list[1]))
        except:
            raise #except: raise pattern raises whatever error occurs
    elif len(argument_list) > 1:
        try:
            with open(argument_list[1]) as file:
                graph_dictionary = graph_dictionary_creator(file, int(argument_list[2]))
        except:
            raise
    else:
        with open('Spruce_fingerprint_2017-03-10_16.48.olp.m4') as file:
            graph_dictionary = graph_dictionary_creator(file, 10)

    graph = Graph(graph_dictionary)
  #  print(graph_dictionary)

    # for key in graph:
    #     print('in graph', key)
    #
    # for key in graph:
    #     tree = graph.bfs(key)
    #     break
    #
    # for bps in tree:
    #     print(bps.get_distance_to_source())
    #
    # graph.create_subgraph_dict()
    # print(graph.components_dictionary)
    # print(graph.get_component_trees())

    graph.compartmentalize()
    graph.write_diameter_path_to_file()
