from graph_representation import *
import pytest


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
    def test_graph_constructor(self):
            graph_dict = {}
            graph_dict['v1'] = {'v2', 'v3'}
            graph_dict['v2'] = {'v1'}
            graph_dict['v3'] = {'v1'}
            graph_dict['v4'] = {}
            graph = Graph(graph_dict)
        vertices = graph.vertex_dictionary
        assert 'v1' and 'v2' and 'v3' and 'v4' in vertices
        graph.create_subgraph_dict()
        subgraph_dict = graph.get_component_dictionary()
        assert len(subgraph_dict) == 2
        for i, j in subgraph_dict.items():
                assert ('v1' and 'v2' and 'v3') or ('v4') in j

