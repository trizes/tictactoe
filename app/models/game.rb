class Game < ApplicationRecord
  STATUSES = {
    running: 'RUNNING',
    x_won: 'X_WON',
    o_won: 'O_WON',
    draw: 'DRAW'
  }.freeze

  MOVES = { X: 0, O: 1 }.freeze

  enum status: ['RUNNING','X_WON','O_WON','DRAW']
  enum next_move: MOVES

  # Various validations to prevent cheating
  validates_presence_of :status
  validates_length_of :board, is: 9
  validates :board, format: {
    with: /\A[XO\-]*\z/, message: 'wrong board state'
  }
  validate :one_move_per_update # Checks move priority, checks that valid move is made

  before_save do
    update_next_move if board_changed?
  end

  def update_next_move
    self.next_move = if next_move == 'X'
                       'O'
                     else
                       'X'
                     end
  end

  def one_move_per_update
    return unless board_changed?

    old_board = board_was.split('')

    changes = []

    board.split('').each_with_index do |val, index|
      next if val == old_board[index]

      changes << val

      if MOVES.keys.include?(old_board[index].to_sym)
        errors.add(:board, 'invalid move made')
        break
      end
    end

    return if changes.length == 1 && changes[0] == next_move

    errors.add(:board, 'invalid move made')
  end

  def make_a_move!
    self.board, self.status = MoveFinder.new(board, next_move).make_a_move!

    save!
  end
end
