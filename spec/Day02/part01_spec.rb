class Submarine
  attr_accessor :horizontal_position

  def initialize
    self.horizontal_position = 0
  end
end

RSpec.describe "Part 01" do
  it "has an initial horizontal position of zero" do
    sub = Submarine.new
    expect(sub.horizontal_position).to eq(0)
  end
end