class Vertex
    attr_accessor :name, :edges, :weights

    def initialize(name)
        @name = name
        @edges = []
        @weights = []
    end

    def add_edge(edge, weight)
        @edges << edge
        @weights << weight
    end
end

class Graph
    attr_accessor :vertices

    def initialize
        @vertices = {}
    end

    def add_vertex(name)
        @vertices[name] = Vertex.new(name)
    end
end

def build_graph(rules)
    graph = Graph.new
    paths_to_gold = 0
    
    rules.each_with_index do |rule, idx|
        vertex_name, edges = rule
        graph.add_vertex(vertex_name)
        edges.each do |edge|
            if edge == "no other bag"
                next
            end

            weight, name = edge.match(/^(\d+) (.*)$/).captures
            weight = weight.to_i
            graph.vertices[vertex_name].add_edge(name, weight)
        end
    end

    graph
end

def traverse_contains_gold?(graph, vertex)
    holds_gold = false

    if vertex.edges.include?("shiny gold bag")
        holds_gold = true
    else
        vertex.edges.each do |edge|
            holds_gold = traverse_contains_gold?(graph, graph.vertices[edge])
            if holds_gold
                break
            end
        end
    end 

    holds_gold
end

def pt_1(graph)
    total = 0
    graph.vertices.each{ |name, vertex| total += traverse_contains_gold?(graph, vertex) ? 1 : 0 }
        
    p total
end

def traverse_weighted(graph, vertex, weight)
    return weight unless vertex.edges.length > 0
    
    sum = 0

    vertex.edges.each_with_index do |edge, idx| 
        sum += traverse_weighted(graph, graph.vertices[edge], vertex.weights[idx] )
    end

    return weight + (weight * sum)
end

def pt_2(graph, gold_bag_vertex)
    total_bags = 0

    gold_bag_vertex.edges.each_with_index do |vertex, idx|
        total_bags += traverse_weighted(graph, graph.vertices[vertex], gold_bag_vertex.weights[idx])
    end

    p total_bags
end

# file = File.open('test_input_pt_2.txt') # => 126
# file = File.open('test_input.txt') # => 32
file = File.open('input.txt') 

rules = file.readlines.map{ |line| line.split('contain').map(&:strip) }
rules.each do |line|
    line[0].delete_suffix!('s')
    line[1].delete_suffix!('.')
    line[1] = line[1].split(',').map{ |bag| bag.strip.delete_suffix('s') }
end

graph = build_graph(rules)
# EDIT: previously I deleted the gold bag to avoid a off-by-one counting error in pt_1,
# but this wasn't necessary
# Q: are there scenarios in which it would contribute to an off-by-one error"
# A: I don't think so, unless a gold bag can contain itself?
gold_bag_vertex = graph.vertices['shiny gold bag']

pt_1(graph)
pt_2(graph, gold_bag_vertex)



