module TicTacToe
    class Board
      attr_accessor :spaces
  
      def initialize
        @spaces = Array.new(9, "-")
      end
  
      def generate_board 
        board = ""
        (0..8).step(3) do |i|
          board += "\t [\t#{@spaces[i]} \t|\t #{@spaces[i + 1]} \t|\t #{@spaces[i + 2]}\t] \n\n"
        end
        puts board + "\n\n"
      end
  
      def add_symbol(position, symbol) 
        @spaces[position] = symbol
      end
  
      def space_taken?(position) 
        return @spaces[position] == "X".red || @spaces[position] == "O".green
      end
    end
  end