require 'pry'
class TicTacToe
  
  WIN_COMBINATIONS = [ 
    [0,1,2], #top row
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]
  #TicTacToe::WIN_COMBINATIONS to access this constant 

  def initialize
    @board = Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    #accepts the user's input (a string) as an argument
    #return corresponding index of the @board array
    # converts string input into an integer (array-friendly format)
    index = input.to_i - 1
  end
  
  def move(idx, token = "X") #(index/ position in board, player's token)
    @board[idx] = token
  end
  
  def position_taken?(idx)
    @board[idx] == "X" || @board[idx] == "O"
  end
  
  def valid_move?(idx)
  # return true if move is valid/ false or nil if not
  # position valid on board
  # not filled w/ token
    idx.between?(0, 8) && !position_taken?(idx)
  end
  
  def turn_count
    # num of turns played based on the @board variable
    turn = 0 
    @board.each {|position| turn += 1 unless position == " " }
    return turn
  end
  
  def current_player
    # *"X" deaulted as first
    # determine if it is "X"/ "O"'s turn
    
    if turn_count % 2 == 0 #currently at odd # count
      # next move/ odd count = "X"'s turn 
      return "X"
    else
      return "O"
    end
    
    # simplified:
    # turn_count % 2 == 0? "X" : "O"
  end
  
  def turn
    # Ask for input (1-9)
    puts "Please enter 1-9"
    # Gets input
    user_input = gets.chomp #remove linebreak from user input string
    
    # Translate  input into index
    position = input_to_index(user_input)
    
    if valid_move?(position) # If the move is valid
        #make the move and display the board
        move(position, current_player)
    else
      #ask for a new move until a valid move is received
      puts "invalid"
      turn
    end
    
    return display_board
  end

  
  def won?
    # return false/nil for a draw OR winning combo for a win 
    # iterate thru each winning combo and compare each row @board's ele with combo's idx
    # i.e. first combo = [0,1,2]
    # combo.map {|idx| @board[idx]} = ["X", "O", "X"]
    # ["X", "O", "X"].join = "XOX" == "XXX"? 
    # repeat process with next set of winning combo <-> @board row
    
    winning_combo = WIN_COMBINATIONS.find { |combo|
      combo.map{ |idx| @board[idx] }.join == "XXX" ||
      combo.map{ |idx| @board[idx] }.join == "OOO"
    }  
    
    # short ver.:
    # WIN_COMBINATIONS.find { |combo|
    # combo.map{ |posit| @board[posit] }.join =~ /X{3}|O{3}/
    # }
  end

  def full?
    #return true if every element in the board contains either an "X" or an "O"
    turn_count == 9
  end
  
  def draw?
    # true if board is full & there's a draw
    # false for won game / in-process game
    full? && !won?
  end
  
  def over?
    # true for draw/ won game
    # false for in-process game
    won? || draw?
  end
  
  def winner
    binding.pry
    # winner = won?.winning_combo[0] 
  end
end
# foo = TicTacToe.initialize
# foo = TicTacToe.initialize(some_kind_of_board)