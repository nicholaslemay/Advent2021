require_relative '../spec_helper'

class BingoGame
  def initialize(drawnNumber, boards)
    @drawnNumber = drawnNumber
    @boards = boards
  end

  def score
    @boards.find_index{|x| x == @drawnNumber}
  end
end

RSpec.describe BingoGame do

  it "score is the index of the winning board" do
    expect(BingoGame.new(22, [33,44,22]).score).to be(2)
  end

end