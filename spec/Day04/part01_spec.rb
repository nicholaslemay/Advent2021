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
      winning_index = @boards.find_index{|board| has_winning_row?(board, drawn_numbers)}
      return winning_index * number if winning_index
    end

  end

  private

  def has_winning_row?(board, drawn_numbers)
    board.any?{|row| row.all?{|x| drawn_numbers.include?(x)}}
  end

end

RSpec.describe BingoGame do

  it "score is the index times the last number of the winning board when won by row" do
    bingo_game_new = BingoGame.new([22, 44, 77], [
      [[1,2],[3,4]],
      [[1,2],[3,4]],
      [[66,77],[22,44]]
    ])
    expect(bingo_game_new.score).to be(2 * 44)
  end

end