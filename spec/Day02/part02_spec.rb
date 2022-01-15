class Submarine
  attr_accessor :horizontal_position, :depth

  def initialize
    self.horizontal_position = self.depth = 0
    @aim = 0
  end

  def forward(increase)
    self.horizontal_position += increase
    self.depth += (increase * @aim)
  end

  def down(increase)
    @aim += increase
  end

  def up(decrease)
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

  it "has an initial depth of zero" do
    expect(sub.depth).to eq(0)
  end

  it "increases horizontal position but not depth on a forward move with no aim" do
    sub.forward(5)
    expect(sub.horizontal_position).to eq(5)
    expect(sub.depth).to eq(0)
  end

  it "with aim increased by going down, moving forward increases depth based on aim" do
    sub.down(5)
    sub.forward(8)
    expect(sub.horizontal_position).to eq(8)
    expect(sub.depth).to eq(8*5)
  end

end

RSpec.describe "Driving a sub from instruction file" do
  let(:sub) { Submarine.new }
  it "can solve the sample" do
    SubmarineDriver.run_from_instructions(sub,'./spec/Day02/sample.txt')
    expect(sub.horizontal_position).to eq(15)
    expect(sub.depth).to eq(60)
  end

  # it "can solve my personal riddle" do
  #   SubmarineDriver.run_from_instructions(sub,'./spec/Day02/input.txt')
  #   expect(sub.horizontal_position).to eq(1906)
  #   expect(sub.depth).to eq(1017)
  # end
end