class Game < ApplicationRecord
  STATUSES = {
    running: 'RUNNING',
    x_won: 'X_WON',
    o_won: 'O_WON',
    draw: 'DRAW'
  }.freeze

  enum status: STATUSES

  validates_length_of :board, is: 9
  validates_presence_of :status
end
