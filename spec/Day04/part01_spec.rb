require_relative '../spec_helper'

class BingoGame
  def initialize(drawnNumbers, boards)
    @drawnNumbers = drawnNumbers
    @boards = boards
  end

  def score
    @boards.find_index{|board| has_winning_row?(board)}
  end

  private

  def has_winning_row?(board)
    board[0].all?{|x| @drawnNumbers.include?(x)}
  end

end

RSpec.describe BingoGame do

  it "score is the index of the winning board when won by row" do
    bingo_game_new = BingoGame.new([22, 44], [
      [[1,2],[3,4]],
      [[1,2],[3,4]],
      [[22,44],[66,77]]
    ])
    expect(bingo_game_new.score).to be(2)
  end

end