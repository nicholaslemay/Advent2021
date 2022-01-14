require_relative '../spec_helper'

class BingoGame
  def score
  end
end

RSpec.describe BingoGame do

  it "returns a bogus score by default" do
    expect(BingoGame.new.score).to be(nil)
  end

end