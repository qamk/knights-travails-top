# frozen-string-literal: true

# 8x8 chess board
class Board
  attr_reader :board
  def initialize(size)
    make_board(size)
  end

  def make_board(size)
    @board = []
    (1..size).each do |row|
      temp_row = []
      (1..size).each { |col| temp_row.push([row, col]) }
      @board.push(temp_row)
    end
  end
end
