class LifeSupportCalculator
  def self.oxygen_generator_rating(diagnostic_entries)
    diagnostic_entries.max_by { |i| diagnostic_entries.count(i) }.to_i(2)
  end
end

RSpec.describe LifeSupportCalculator do

  describe 'oxygen rating' do
    it 'returns the most popular diagnostic of a single bit' do
      diagnostics = %w(1 0 0 1 0)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(0)

      diagnostics = %w(1 1 1 1 0)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
    end
  end
end

RSpec.describe "Calculating the life support from a real diagnostic" do

  it "resolves riddle sample" do
    diagnostic = File.readlines('./spec/Day03/sample.txt', chomp: true)
    expect(LifeSupportCalculator.oxygen_generator_rating(diagnostic)).to eq(23)
  end

end