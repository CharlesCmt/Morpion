require_relative "./lib/game"
require_relative "./lib/player"
require_relative "./lib/board"

module TicTacToe
  class TicTacToeRunner
    attr_accessor :name1, :name2, :game_data

    def initialize
      @game_data = {
        player1: {name: nil, wins: nil},
        player2: {name: nil, wins: nil},
        draws: nil
      }
      welcome_screen
      game_loop
    end

    def welcome_screen #greets players and asks for their names
      puts "\n|| Welcome to Tic Tac Toe ! ||"
      puts "||--------------------------||\n\n\n"
      print "Enter Player 1's name: "
      @name1 = gets.chomp
      puts " "
      print "Enter Player 2's name: "
      @name2 = gets.chomp
      puts " "
    end

    def game_loop #loops between prompting for new game and running the game.
      loop do
        game_start
        break unless play_again?
      end
    end

    def game_start #initiates a new game
      board = Board.new
      player1, player2 = Player.new(@name1), Player.new(@name2)
      game = Game.new(player1, player2, board)
    end

    def play_again?
      loop do
        print "Would you like to play again? (Y/N): "
        input = gets.chomp.upcase
        if input == "Y"
          return true
        elsif input == "N"
          return false
        end
      end
    end
  end
end

game = TicTacToe::TicTacToeRunner.new