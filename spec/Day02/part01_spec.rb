class Submarine
  attr_accessor :horizontal_position

  def initialize
    self.horizontal_position = 0
  end

  def forward(increase)
    self.horizontal_position += increase
  end
end

RSpec.describe "Part 01" do
  let(:sub) { Submarine.new }

  it "has an initial horizontal position of zero" do
    expect(sub.horizontal_position).to eq(0)
  end

  it "increases horizontal position on a forward move " do
    sub.forward(5)
    expect(sub.horizontal_position).to eq(5)

    sub.forward(8)
    expect(sub.horizontal_position).to eq(13)
  end
end