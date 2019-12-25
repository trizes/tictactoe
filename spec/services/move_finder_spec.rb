require 'rails_helper'

RSpec.describe MoveFinder do
  describe '#game_won?' do
    context 'rows' do
      it 'is true when X is in first row' do
        subject = MoveFinder.new('XXX------', 'X')

        expect(subject.game_won?).to eq true
      end

      it 'is true when O is in second row' do
        subject = MoveFinder.new('---OOO---', 'O')

        expect(subject.game_won?).to eq true
      end

      it 'is true when O is in third row' do
        subject = MoveFinder.new('------OOO', 'O')

        expect(subject.game_won?).to eq true
      end
    end

    context 'columns' do
      it 'is true when X is in first column' do
        subject = MoveFinder.new('X--X--X--', 'X')

        expect(subject.game_won?).to eq true
      end

      it 'is true when O is in second column' do
        subject = MoveFinder.new('-O--O--O-', 'O')

        expect(subject.game_won?).to eq true
      end

      it 'is true when X is in third column' do
        subject = MoveFinder.new('--X--X--X', 'X')

        expect(subject.game_won?).to eq true
      end
    end

    context 'diagonals' do
      it 'is true when X is in first diagonal' do
        subject = MoveFinder.new('X---X---X', 'X')

        expect(subject.game_won?).to eq true
      end

      it 'is true when O is in second diagonal' do
        subject = MoveFinder.new('--O-O-O--', 'O')

        expect(subject.game_won?).to eq true
      end
    end
  end

  describe '#minimax' do
    it 'returns 1 if X won on its turn' do
      subject = MoveFinder.new('XXX------', 'X')

      expect(subject.minimax).to eq 1
    end

    it 'returns 1 if O won on O turn' do
      subject = MoveFinder.new('OOO------', 'O')

      expect(subject.minimax).to eq 1
    end

    it 'returns -1 if X won on O turn' do
      subject = MoveFinder.new('XXX------', 'O')

      expect(subject.minimax).to eq -1
    end

    it 'returns -1 if O won on X turn' do
      subject = MoveFinder.new('OOO------', 'X')

      expect(subject.minimax).to eq -1
    end

    it 'returns 0 if it is a draw' do
      subject = MoveFinder.new('OXXXXOOOX', 'O')

      expect(subject.minimax).to eq 0
    end

    it 'returns 1 if X is about to win' do
      subject = MoveFinder.new('O--XX-O--', 'X')

      expect(subject.minimax).to eq 1
    end

    it 'returns -1 if O is about to win' do
      subject = MoveFinder.new('XXOX--OO-', 'X')

      expect(subject.minimax).to eq -1
    end
  end

  describe '#make_a_move!' do
    it 'returnx X_WON' do
      subject = MoveFinder.new('XX-OO----', 'X')

      expect(subject.make_a_move!).to eq ['XXXOO----', 'X_WON']
    end

    it 'returns O_WON' do
      subject = MoveFinder.new('XXOXO----', 'O')

      expect(subject.make_a_move!).to eq ['XXOXO-O--', 'O_WON']
    end

    it 'shows RUNNING status' do
      subject = MoveFinder.new('O--X-----', 'X')

      expect(subject.make_a_move!).to eq ['OX-X-----', 'RUNNING']
    end

    it 'announces DRAW' do
      subject = MoveFinder.new('OXXXXOOOX', 'O')

      expect(subject.make_a_move!).to eq ['OXXXXOOOX', 'DRAW']
    end
  end

  describe '#best_move' do
    it 'returns best next move for X' do
      subject = MoveFinder.new('OO-XX-OX-', 'X')

      subject.minimax

      expect(subject.best_move).to eq 5
    end

    it 'returns best next move for O' do
      subject = MoveFinder.new('OO-OXXXX-', 'O')

      subject.minimax

      expect(subject.best_move).to eq 2
    end
  end
end
