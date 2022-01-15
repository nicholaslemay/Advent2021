class LifeSupportCalculator
  def self.oxygen_generator_rating(diagnostic_entries)
  end
end

RSpec.describe "Calculating the life support from a real diagnostic" do

  it "resolves riddle sample" do
    diagnostic = File.readlines('./spec/Day03/sample.txt', chomp: true)
    expect(LifeSupportCalculator.oxygen_generator_rating(diagnostic)).to eq(23)
  end

end