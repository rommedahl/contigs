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
    testing class Graph, be sure to stand in main /contigs directory
    '''
    def test_graph_dictionary_creator(self):
        '''
        Ensures that all the values is also keys (vertices) i.e neighbors are also vertices. It also control some file handling.
        '''
        with open('bin/test_data_graph_dic_creator.txt') as file: # note that you might have to change the search.
            graph_dictionary = graph_dictionary_creator(file, 5)
        for elm in list(graph_dictionary.values()):
            if len(list(elm)) > 1:
                for i in list(elm):
                    assert i in list(graph_dictionary.keys())
            else:
                assert list(elm)[0] in list(graph_dictionary.keys())

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
        graph.compartmentalize()
        component_trees = graph.get_component_trees()
        assert len(component_trees) == 2
        for tree in component_trees:
            v_list = []
            for branch in tree:
                v_list.append(branch.get_vertex().get_key())
            assert set(v_list) == {'v1', 'v2', 'v3', 'v5', 'v6'} \
                or v_list == ['v4']                   # set för att kontrollera att elementen är lika oavsett index


if __name__ == '__main__':
    test = TestGraph()
    test.test_graph_dictionary_creator()
    test.test_graph_constructor()
    test.test_component_diameter()
    test.test_graph_compartmentalize()
