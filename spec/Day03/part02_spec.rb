class LifeSupportCalculator
  def self.oxygen_generator_rating(diagnostic_entries)

    valid_diagnostics = diagnostic_entries
    (0...diagnostic_entries[0].length).each do |bit_index|
      bits_grouped_together = valid_diagnostics.map(&:chars).transpose
      bits = bits_grouped_together[bit_index]
      most_frequent_bit = bits.count('0') > bits.count('1') ? '0' : '1'
      valid_diagnostics = valid_diagnostics.select{|d| d[bit_index] == most_frequent_bit}

      if(valid_diagnostics.length == 1)
        return valid_diagnostics[0].to_i(2)
      end
    end
  end
end

RSpec.describe LifeSupportCalculator do

  describe 'oxygen rating' do
    it 'returns the most popular diagnostic of a single bit' do
      diagnostics = %w(0)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(0)

      diagnostics = %w(1)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
    end

    it 'in a tie, 1 wins' do
      diagnostics = %w(0 1)
      expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
    end

    describe 'with a multiple bits diagnostic' do
      it 'returns the most popular diagnostic for each bit' do
        diagnostics = %w(00 01)
        expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be(1)
      end

      it 'returns the one diagnostic, matching most frequent bits, from left to right' do
        diagnostics = %w(101 100 110 000)
        expect(LifeSupportCalculator.oxygen_generator_rating(diagnostics)).to be('101'.to_i(2))
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