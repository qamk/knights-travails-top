# frozen-string-literal: true

# Represent the network of moves
class Graph
  attr_accessor :adjacency_list
  attr_reader :vertex_count
  def initialize
    @adjacency_list = {}
  end

  def add_vertex(name)
    adjacency_list[name] = []
  end

  def add_edge(point_a, point_b)
    adjacency_list[point_a].push(point_b)

    add_vertex(point_b) unless adjacency_list.include? point_b
    adjacency_list[point_b].push(point_a)
  end

  def breadth_first_traversal(vertex, goal)
    visited = [vertex] # undirected
    path = []
    queue = [vertex]
    until queue.empty?
      return path << goal if visited.include? goal

      active_vertex = queue.shift
      path << active_vertex
      vertex_connections = adjacency_list[active_vertex]
      # print "\e[33m#{active_vertex}: \e[34m#{vertex_connections}\e[0m\n"
      vertex_connections.each do |vert|
        if !visited.include? vert
          visited << vert
          queue << vert
        end
      end
    end
  end
end
