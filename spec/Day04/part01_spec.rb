require_relative '../spec_helper'

class BingoGame
  def initialize(number_sequence, boards)
    @number_sequence = number_sequence
    @boards = boards
  end

  def score
    drawn_numbers = []
    @number_sequence.each do |number|
      drawn_numbers << number
      winning_board = @boards.find{|board| has_winning_row?(board, drawn_numbers) || has_winning_column?(board, drawn_numbers)}
      return score_from(winning_board, drawn_numbers) * number if winning_board
    end
  end

  private

  def has_winning_row?(board, drawn_numbers)
    board.any?{|row| row.all?{|n| has_been_drawn?(n, drawn_numbers)}}
  end

  def has_winning_column?(board, drawn_numbers)
    board.transpose.any?{|column| column.all?{|n| has_been_drawn?(n, drawn_numbers)}}
  end

  def score_from(winning_board, drawn_numbers)
    winning_board.flatten.reject{|n| has_been_drawn?(n, drawn_numbers)}.sum
  end

  def has_been_drawn?(n, drawn_numbers)
    drawn_numbers.include?(n)
  end
end

class BingoInput
  attr_accessor :number_sequence

  def initialize(number_sequence)
    self.number_sequence = number_sequence
  end

  def self.from(filename)
    lines = File.readlines(filename)

    return BingoInput.new(number_sequence_from(lines))
  end

  private

  def self.number_sequence_from(lines)
    lines[0].split(',').map(&:to_i)
  end
end

RSpec.describe BingoInput do

  it "return the number sequence to play with" do
    bingo_input = BingoInput.from('./spec/Day04/sample.txt')

    expect(bingo_input.number_sequence).to match_array([7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
  end
end


RSpec.describe BingoGame do

  describe "a winning board by row" do
    it "scores is the last number drawn * the sum of winning's board undrawn numbers" do
      bingo_game_new = BingoGame.new([22, 44, 77], [
        [[1,2],[3,4]],
        [[1,2],[3,4]],
        [[66,77],[22,44]]
      ])
      expect(bingo_game_new.score).to be(44 * (66 + 77))
    end
  end

  describe "a winning board by column" do
    it "scores is the last number drawn * the sum of winning's board undrawn numbers" do
      bingo_game_new = BingoGame.new([7, 8, 77], [
        [[1,2],[3,4]],
        [[7,2],[8,4]],
      ])
      expect(bingo_game_new.score).to be(8 * (2 + 4))
    end
  end

end


