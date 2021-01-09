# frozen-string-literal: true

require_relative 'board.rb'
require_relative 'graph.rb'

# A chess knight and its moves
class Knight
  attr_reader :moves, :goal, :start_position, :board, :graph
  def initialize(start_position, goal)
    @start_position = start_position
    @goal = goal
    @moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-2, -1], [-1, -2], [-2, 1], [-1, 2]]
    @board = Board.new(8).board
    @graph = Graph.new
    create_board_graph
    # p graph
    knights_move(9, 60)
  end

  def create_board_graph
    board.each_with_index do |row, r_index|
      row.each_with_index do |_col, c_index|
        cell = board[r_index][c_index]
        label = convert_cell(cell[0], cell[1])
        move_to = legal_cells(cell).map { |move| convert_cell(move[0], move[1]) }
        # puts "\e[33m#{label}\e[0m: \e[34m#{move_to.map { |move| convert_label(move) }} ........ #{move_to}\e[0m"
        add_conntection(label, move_to)
      end
    end
  end

  def add_conntection(vertex, vertex_links)
    graph.add_vertex(vertex)
    vertex_links.each do |link|
      graph.add_edge(vertex, link)
    end
  end

  def knights_move(start_vertex, goal)
    traversed = graph.breadth_first_traversal(start_vertex, goal)
    index = 0
    final_path = traversed.select do |vert|
      next(true) if [start_vertex, goal].include? vert

      current_connections = graph.adjacency_list[vert]
      index += 1
      keep = traversed[index..-1].any? do |visited_verts|
        puts "Vert in question: \e[31m#{vert}\e[0m\n\tInner Vert: \e[32m#{visited_verts}\e[0m\n\tSearching: \e[33m#{traversed[index..-1]}\e[0m\n\tComparing to: \e[34m#{current_connections}\e[0m\n\tInner Choice: \e[35m#{current_connections.include? visited_verts}\e[0m"
        current_connections.include? visited_verts
      end
    end
    final_path = clean(final_path, start_vertex, goal)
    p "original: #{traversed}"
    p "final: #{final_path}"
  end

  def clean(path, start_vertex, goal)
    parent = path[0]
    path.select! do |vert|
      next(true) if [start_vertex, goal].include? vert

      parent_connections = graph.adjacency_list[parent]
      puts "Parent #{parent}\n\tConnections: #{parent_connections}\n\tVertex: #{vert}\n\tPath: #{path}"
      if parent_connections.include? vert
        parent = vert
        next(true)
      end

    end
  end

  def convert_cell(row, col)
    col + 8 * row
  end

  def convert_label(label)
    row = label / 8
    col = label % 8
    return [row, col] unless col.zero?

    [row, 8]
  end

  def legal_cells(position)
    move_to = moves.map do |move|
      [position[0] + move[0], position[1] + move[1]]
    end
    move_to.select { |move| valid_position(move) }
  end

  def valid_position(position)
    position.all? { |pos| pos.between?(1, 8) }
  end
end

Knight.new(nil, nil)
