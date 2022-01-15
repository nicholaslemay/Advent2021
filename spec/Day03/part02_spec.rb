class LifeSupportCalculator
  def self.oxygen_generator_rating(diagnostic_entries)
    bits_grouped_together = diagnostic_entries.map(&:chars).transpose
    most_frequent_bits = bits_grouped_together.collect { |bits|
      bits.count('0') > bits.count('1') ? '0'.to_i(2) : '1'.to_i(2)
    }.join
    most_frequent_bits.to_i(2)
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

    it 'in a tie, 1 wins' do
      diagnostics = %w(0 0 1 1)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
    end

    describe 'with a multiple bits diagnostic' do
      it 'returns the most popular diagnostic for each bit' do
        diagnostics = %w(00 01)
        expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
      end
    end
  end
end

RSpec.describe "Calculating the life support from a real diagnostic" do

  it "resolves riddle sample" do
    diagnostic = File.readlines('./spec/Day03/sample.txt', chomp: true)
    expect(LifeSupportCalculator.oxygen_generator_rating(diagnostic)).to eq(23)
  end

end