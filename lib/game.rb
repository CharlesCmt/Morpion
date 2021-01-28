require_relative "board"
require_relative "player"

module TicTacToe
  class Game
    attr_accessor :player1, :player2, :turn, :board

    @@winning_positions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    def initialize(player1, player2, board)
      @player1 = player1
      @player2 = player2
      @board = board
      @current_turn_player = nil
      @turn_count = 1
      @winner = nil

      #executes game flow
      play
    end

    def play #main flow of game
      pick_first_turn
      allocate_symbols
      take_turns
    end

    private

    def pick_first_turn #a player is randomly chosen to go first
      @current_turn_player = [@player1, @player2].sample
      puts "#{@current_turn_player} goes first!\n\n\n\n"
    end

    def allocate_symbols
      @player1.sym = "X"
      @player2.sym = "O"
    end

    def take_turns
      until game_end?
        turn(@current_turn_player)
        next_turn
      end
      puts "Game was a draw!" if draw?
    end

    def next_turn
      @current_turn_player = @current_turn_player == @player1 ? @player2 : @player1
      @turn_count += 1
    end

    def game_end?
      draw? || !@winner.nil?
    end

    def turn(player) #one turn for a player
      puts "Turn #{@turn_count}:"
      puts "---------------------------\n\n\n"
      @board.generate_board
      @board.add_symbol(get_valid_position(player), player.sym)
      announce_win(player)
    end

    def get_valid_position(player)
      input = 0
      until valid_input?(input)
        print "#{player.name}, enter the cell number that you would like to use (1-9): "
        input = gets.chomp.to_i
        print "Invalid input! " unless valid_input?(input)
        puts "Number is not in range 1-9" unless (input > 0 && input < 10)
        puts "Cell taken." if @board.space_taken?(input - 1)
        puts "\n\n"
      end
      input - 1
    end

    def announce_win(player)
      check_winner(player)
      if @winner == player.name
        puts "#{player.name} is the winner!"
      end
    end

    def draw?
      (@turn_count == @board.spaces.length) && (@winner.nil?)
    end

    def check_winner(player) #if a player is a winner, the @winner instance var is set to that player
      @@winning_positions.each do |triplet|
        @winner = player.name if triplet.all? { |a| @board.spaces[a] == player.sym }
      end
    end

    def valid_input?(input)
      input > 0 && input < 10 && !@board.space_taken?(input - 1)
    end
  end
end