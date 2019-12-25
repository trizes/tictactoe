require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'validates presence of board' do
    subject.board = ''

    expect(subject).not_to be_valid

    expect(subject.errors.messages[:board]).to include(
      'is the wrong length (should be 9 characters)'
    )
  end

  it 'validates presence of status' do
    subject.status = ''

    expect(subject).not_to be_valid

    expect(subject.errors.messages[:status]).to include(
      'can\'t be blank'
    )
  end

  it 'validates board to valid characters only' do
    subject.board = '123---XXO'

    expect(subject).not_to be_valid

    expect(subject.errors.messages[:board]).to include(
      'wrong board state'
    )
  end

  it 'validates that newly created game has only one move' do
    subject.board = '---XXX---'

    subject.save

    expect(subject.errors.messages[:board]).to include(
      'invalid move made'
    )
  end

  it 'validates move is made by correct side' do
    subject.board = '-X-------'
    subject.save!

    subject.board = '-XX------'

    expect(subject).not_to be_valid
    expect(subject.errors.messages[:board]).to include(
      'invalid move made'
    )
  end

  it 'validates that move can\'t be overridden' do
    subject.board = '-X-------'
    subject.save!

    subject.board = '-O-------'

    expect(subject).not_to be_valid
    expect(subject.errors.messages[:board]).to include(
      'invalid move made'
    )
  end

  describe '#make_a_move!' do
    it 'makes a new move for X' do
      subject.board = '-X-------'
      subject.save

      subject.make_a_move!

      expect(subject.board).to include('O')
      expect(subject.status).to eql 'RUNNING'
    end

    it 'marks a game as a draw' do
      subject.save

      subject.update_columns(
        board: 'OXXXXOOO-',
        next_move: 'X'
      )

      subject.make_a_move!

      expect(subject.board).to include('O')
      expect(subject.status).to eql 'DRAW'
    end
  end
end
