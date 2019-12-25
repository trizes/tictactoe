class MoveFinder
  def initialize(board, next_move)
    @board = board.split('')
    @next_move = next_move
    @best_move = -1
  end

  attr_reader :board, :next_move, :best_move

  # Main interface for the class.
  # Class user will get a move and game status update
  def make_a_move!
    minimax

    # If a game is won/lost or if it's a draw, no move
    # should be suggested
    if board[best_move] == '-'
      board[best_move] = next_move
    end

    [board.join, game_status]
  end

  # Test of all possible tictactoe win positions
  # to see if any side has won.
  def game_won?(board=@board, side=@next_move)
    board_rows = board.each_slice(3).to_a

    board_rows.any? { |set| set.all?{|el| el == side} } ||
    board_rows.transpose.any? { |set| set.all?{|el| el == side} } ||
    [2,1,0].map{|index| board_rows[index][index]}.all?{|el| el == side} ||
    [2,1,0].map{|index| board_rows[index].reverse[index]}.all?{|el| el == side}
  end

  # Recursive check of all possible board state branches
  def minimax(board=@board, side=@next_move, depth=1)
    # Check if game won by our side or opponent
    if game_won?(board, side)
      return 1
    elsif game_won?(board, opponent(side))
      return -1
    end

    move = -1
    score = -2

    board.each_with_index do |val, index|
      next if val != '-'

      new_board = board.dup
      new_board[index] = side # Testing a move

      # Find the score of the move from opponent side
      new_move_score = -minimax(new_board, opponent(side), (depth + 1))

      if new_move_score > score
        score = new_move_score
        move = index
        @best_move = index if depth == 1 # Required to decide which move to make
      end
    end

    score = 0 if move == -1

    score
  end

  def game_status
    if game_won?
      "#{next_move}_WON"
    elsif board.none?{|val| val == '-'}
      'DRAW'
    else
      'RUNNING'
    end
  end

  def opponent(side)
    if side == 'X'
      'O'
    else
      'X'
    end
  end
end
