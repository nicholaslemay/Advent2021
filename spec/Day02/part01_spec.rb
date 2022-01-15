class Submarine
  attr_accessor :horizontal_position, :depth

  def initialize
    self.horizontal_position = self.depth = 0
  end

  def forward(increase)
    self.horizontal_position += increase
  end

  def down(increase)
    self.depth += increase
  end

  def up(decrease)
    self.depth -= decrease
  end
end

class SubmarineDriver
  def self.run_from_instructions(sub, file)
    File.readlines(file).each do |instruction_line|
      instruction, value = instruction_line.split(' ')
      sub.send(instruction.to_sym, value.to_i)
    end
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

  it "has an initial depth of zero" do
    expect(sub.depth).to eq(0)
  end

  it "can go down in depth " do
    sub.down(4)
    expect(sub.depth).to eq(4)

    sub.down(8)
    expect(sub.depth).to eq(12)
  end

  it "can go up in depth " do
    sub.down(5)
    sub.up(3)
    expect(sub.depth).to eq(2)
  end
end

RSpec.describe "Driving a sub from instruction file" do
  let(:sub) { Submarine.new }
  it "can solve the sample" do
    SubmarineDriver.run_from_instructions(sub,'./spec/Day02/sample.txt')
    expect(sub.horizontal_position).to eq(15)
    expect(sub.depth).to eq(10)
  end

  it "can solve my personal riddle" do
    SubmarineDriver.run_from_instructions(sub,'./spec/Day02/input.txt')
    expect(sub.horizontal_position).to eq(1906)
    expect(sub.depth).to eq(1017)
  end
end