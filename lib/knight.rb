# frozen-string-literal: true

require_relative 'board.rb'
require_relative 'graph.rb'
require_relative 'mechanics.rb'

# A chess knight and its moves
class Knight
  include Mechanics
  attr_reader :moves, :goal, :raw_goal, :start_position, :board, :graph
  def initialize(start_position, goal)
    @start_position = convert_cell(start_position[0], start_position[1])
    @goal = convert_cell(goal[0], goal[1])
    @raw_goal = goal
    @moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-2, -1], [-1, -2], [-2, 1], [-1, 2]]
    @board = Board.new(8).board
    @graph = Graph.new
    create_board_graph
    display_results
  end

  def no_move
    puts 'No move necessary...'
  end

  def display_results
    return no_move if goal == start_position

    knights_move.each_with_index { |label, index| print "    #{index + 1} ---> #{colour_path(label)}" }
  end

  def colour_path(label)
    if label == goal
      "\t\e[38;5;#{rand(2..15)}m#{raw_goal}\e[0m\n"
    else
      "\t\e[38;5;#{rand(131..230)}m#{convert_label(label)}\e[0m\n"
    end
  end

  def create_board_graph
    board.each_with_index do |row, r_index|
      row.each_with_index do |_col, c_index|
        cell = board[r_index][c_index]
        label = convert_cell(cell[0], cell[1])
        move_to = legal_moves(cell).map { |move| convert_cell(move[0], move[1]) }
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

  def knights_move
    traversed = graph.breadth_first_traversal(start_position)
    pathways = connected_nodes(traversed)
    knights_path = find_knights_path(pathways)
    # p "pre-clean: #{pathways}"
    # puts "\e[1;38;5;1mFINAL\e[0m"
    # print "#{[start_position] + knights_path}\n\n"
    print "From \e[#{rand(31..35)}m#{convert_label(start_position)}\e[0m to  \e[#{rand(31..35)}m#{raw_goal}\e[0m\n\n"
    knights_path
  end
end

# Knight.new([rand(1..8),rand(1..8)], [rand(1..8),rand(1..8)])
