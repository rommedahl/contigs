from graph_representation import *
import pytest


def create_graph():
    graph_dict = {}
    graph_dict['v1'] = {'v2', 'v3'}
    graph_dict['v2'] = {'v1'}
    graph_dict['v3'] = {'v1', 'v5'}
    graph_dict['v4'] = {}
    graph_dict['v5'] = {'v3', 'v6'}
    graph_dict['v6'] = {'v5'}
    graph = Graph(graph_dict)
    return graph

class TestVertex:
    def test_add_neighbour(self):
        neighbour_list = []
        vertex = Vertex('main')
        for chr in '0123456789':
            vertex.add_neighbour(Vertex(int(chr)))
        for v in vertex.get_neighbours():
            neighbour_list += [v.get_key()]
        assert len(neighbour_list) == 10
        for chr in '0123456789':
            assert int(chr) in neighbour_list

class TestGraph:
    '''
    testing class Graph
    '''
    def test_graph_constructor(self):
        '''
        ensures vertices entered into graph are found in graph
        '''
        graph = create_graph()
        vertices = graph.vertex_dictionary
        assert 'v1' and 'v2' and 'v3' and 'v4' in vertices

    def test_graph_compartmentalize(self):
        '''
        tests compartmentalize, ensures correct vertices are put in separate subtrees
        '''
        graph = create_graph()
        graph.create_subgraph_dict()
        subgraph_dict = graph.get_component_dictionary()
        assert len(subgraph_dict) == 2
        for i, j in subgraph_dict.items():
                assert ('v1' and 'v2' and 'v3' in j) ^ ('v4' in j)

    def test_component_diameter(self):
        graph = create_graph()
        graph.compartmentalize()
        sub_trees = graph.get_component_trees()
        t1 = sub_trees[0]
        t2 = sub_trees[1]
        t1_diameter, path = graph.component_diameter(t1, 5)
        t2_diameter, x = graph.component_diameter(t2, 5)
        assert t1_diameter == 4
        assert t2_diameter == 0
        assert 'v2' and 'v1' and 'v3' and 'v5' and 'v6' in path



if __name__ == '__main__':
    pass
