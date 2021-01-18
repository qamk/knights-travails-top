# frozen-string-literal: true

# Methods for interacting with (but not creating) the graph
module Mechanics
  # Selects vertices which have children in the current path
  def connected_nodes(traversed)
    index = 0
    traversed.select do |vert|
      next(true) if [start_position, goal].include? vert

      vert_connections = graph.adjacency_list[vert]
      index += 1
      traversed[index..-1].any? do |visited_verts|
        vert_connections.include? visited_verts
      end
    end
  end

  def find_knights_path(path)
    unclean_path = path.clone
    cleaned_path = [unclean_path.shift]
    loop do
      cleaned_path = clean(unclean_path)
      # puts "\e[33mCleaned?\e[0m: #{cleaned_path}"
      break if cleaned_path.include? goal

      to_pop_from_path = cleaned_path.pop
      unclean_path.delete(to_pop_from_path)
    end
    # print "\e[91mPath\e[0m: #{cleaned_path}\n"
    cleaned_path
  end

  def clean(path)
    parent = path[0]
    path.select do |vert|
      next(true) if parent == vert

      parent_connections = closer_only(graph.adjacency_list[parent], parent)
      vert_connections = closer_only(graph.adjacency_list[vert], vert)
      # puts "Parent #{parent}\n\tConnections: #{parent_connections}\n\tVertex: #{vert}\n\tPath: #{path}"
      if (parent_connections.include? vert) && (mutual_connections?(vert_connections, path, parent) || vert == goal)
        parent = vert
        next(true)
      end
    end
  end

  def closer_only(path, active_vert)
    path.select { |vert| closer(active_vert, vert) }
  end

  def closer(parent, vert, destination = goal)
    (vert - destination).abs < (parent - destination).abs
  end

  def mutual_connections?(knight_path, reference_path, parent)
    knight_path.any? do |vert|
      reference_path.include? vert unless vert == parent
    end
  end

  def convert_cell(row, col)
    col + 8 * row
  end

  def convert_label(label)
    row = label / 8
    col = label % 8
    return [row, col] unless col.zero?

    [row - 1, 8]
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
