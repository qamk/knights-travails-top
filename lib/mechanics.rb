# frozen-string-literal: true

# Methods for interacting with (but not creating) the graph 
module Mechanics
  def connected_nodes(traversed)
    index = 0
    traversed.select do |vert|
      next(true) if [start_position, goal].include? vert

      current_connections = graph.adjacency_list[vert]
      index += 1
      traversed[index..-1].any? do |visited_verts|
        # puts "Vert in question: \e[31m#{vert}\e[0m\n\tInner Vert: \e[32m#{visited_verts}\e[0m\n\tSearching: \e[33m#{traversed[index..-1]}\e[0m\n\tComparing to: \e[34m#{current_connections}\e[0m\n\tInner Choice: \e[35m#{current_connections.include? visited_verts}\e[0m"
        current_connections.include? visited_verts
      end
    end
  end

  def clean(path)
    parent = path[0]
    path.select do |vert|
      next(true) if [start_position, goal].include? vert

      parent_connections = graph.adjacency_list[parent]
      vert_connections = graph.adjacency_list[vert]
      # puts "Parent #{parent}\n\tConnections: #{parent_connections}\n\tVertex: #{vert}\n\tPath: #{path}"
      if (parent_connections.include? vert) && mutual_connections?(path, vert_connections, parent) && closer(parent, vert)
        # print "\e[1m#{vert}\e[0m belongs in \e[32mparent\e[0m \e[1m#{parent}\e[0m\n\t\e[31mpath\e[0m (#{path}) has mutual connections with \e[33mvert\e[0m (#{vert_connections})\n"
        parent = vert
        next(true)
      end
    end
  end

  def closer(parent, vert)
    (vert - goal).abs < (parent - goal).abs
  end

  def mutual_connections?(path, vert_connections, parent)
    path.any? do |vert|
      vert_connections.include? vert unless vert == parent
    end
  end

  def convert_cell(row, col)
    col + 8 * row
  end

  def convert_label(label)
    row = label / 8
    col = label % 8

    return [row, col] unless col.zero?


    [row-1, 8]
  end

  def legal_moves(position)
    move_to = moves.map do |move|
      [position[0] + move[0], position[1] + move[1]]
    end
    move_to.select { |move| valid_position?(move) }
  end

  def valid_position?(position)
    return false unless position.size == 2

    position.all? { |pos| pos.between?(1, 8) }
  end

end