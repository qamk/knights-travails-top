# frozen-string-literal: true

require_relative 'lib/knight.rb'
require_relative 'lib/mechanics.rb'

# Interface for Knights Travails
class KnightsTravails
  include Mechanics
  def initialize
    welcome
    play
  end

  def welcome
    puts %(
      Welcome to \e[1;4;95mKnights Travails\e[0m.
      This program uses a \e[1;32mgraph\e[0m to give you the \e[33mshortest path\e[33m for a \e[1mchess knight\e[0m to go from A to B.
      The graph uses an \e[1madjacency list\e[0m (even though the graph is not sparse I prefered it for listing neighbours efficiently).
      Anyway, what this means is that the program searches, using \e[33mBreadth First Traversal\e[0m (BFT) in my case, a network of vertices.
      Each vertex represents a square on the 8x8 chess board.
      \e[2mIf you opt to "un-comment" (remove the #) any of the puts or print lines, you may notice they use 2-digit numbers.
      These numbers are a "label" for each square, e.g. the square [1, 1] becomes 9, [1, 2] --> 10 and so on.
      This is because I prefered to\e[1m not\e[0;2m use arrays as keys.\e[0m
      Anyway, all that aside, I hope you like this dive into using graphs!
      (I am aware I did not write this as a script, I just preferred this.)
    )
  end

  def prompt
    puts "A square/position is represented as \e[1m[row, coloumn]\e[0m so [3, 5] is 3 down and 5 across\n"
    print 'Enter coordinates for the starting position (point A, e.g. \'5, 7\'): '
    point_a = gets.chomp.strip.split(',').map(&:to_i)
    print 'Enter coordinates for the destination position (point B e.g. \'2, 1\'): '
    point_b = gets.chomp.strip.split(',').map(&:to_i)
    valid = valid_position?(point_a) && valid_position?(point_b)
    valid ? [point_a, point_b] : valid_input_reminder
  end

  def valid_input_reminder
    puts %(
      --------------------------------------------
      Remember this is an \e[1m8x8 grid\e[0m, the top left square is [1, 1] and the bottom right is [8, 8].
      Anything in-between (no values under 1 or over 8) is valid.
      --------------------------------------------
    )
  end

  def break_play?
    print 'Enter \'q\' to quit. Anything else to try with new coordinates: '
    gets.chomp.downcase == 'q'
  end

  def outro
    puts "Thanks for using this \e[1;95mKnights Travails\e[0m. Hope you enjoyed it!"
  end

  def play
    valid_input_reminder
    loop do
      coords = prompt
      next if coords.nil?

      Knight.new(coords[0], coords[1])
      break if break_play?
    end
    outro
  end
end

KnightsTravails.new
