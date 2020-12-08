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

# file = File.open('test_input.txt')
file = File.open('input.txt')
rules = file.readlines.map{ |line| line.split('contain').map(&:strip) }
rules.each do |line|
    line[0].delete_suffix!('s')
    line[1].delete_suffix!('.')
    line[1] = line[1].split(',').map{ |bag| bag.strip.delete_suffix('s') }
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

def nvm
    graph.vertices.values.each do |vertex|
        if vertex.name == 'shiny gold bag'
            next
        end

        vertex.edges.each do |edge|
            current_vertex_name = edge
            if edge == 'shiny gold bag'
                paths_to_gold += 1
                break
            end

            while !graph.vertices[edge.name].edges.nil?
                current_vertex_name = graph.vertices[edge.name].name
            end
        end
    end
end

def traverse_contains_gold?(graph, vertex)
    puts "#{vertex.name}: #{vertex.edges}"
    holds_gold = false

    # if vertex.name == "shiny gold bag"
    #     return 1
    # end

    if vertex.edges.include?("shiny gold bag")
        # pp vertex
        return holds_gold = true
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
    # graph.vertices.each{ |name, vertex| total += traverse(graph, vertex) }
    graph.vertices.each do |name, vertex| 
        total += traverse_contains_gold?(graph, vertex) ? 1 : 0
        puts "Total: #{total}"
    end 
    p total
end

graph = build_graph(rules)
# delete gold bag to avoid off-by-one counting error 
graph.vertices.delete('shiny gold bag')
pt_1(graph)


