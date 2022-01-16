class LifeSupportCalculator

  def self.oxygen_generator_rating(diagnostic_entries)
    diagnostic_matching(diagnostic_entries, :most_frequent).to_i(2)
  end

  def self.scrubber_rating(diagnostic_entries)
    diagnostic_matching(diagnostic_entries, :least_frequent).to_i(2)
  end

  private

  def self.diagnostic_matching(diagnostic_entries, strategy)
    valid_diagnostics = diagnostic_entries
    (0...diagnostic_entries[0].length).each do |index|
      most_frequent_bit = most_frequent_bit(index, valid_diagnostics)
      valid_diagnostics = valid_diagnostics.select { |d|
         strategy == :most_frequent ? d[index] == most_frequent_bit : d[index] != most_frequent_bit
      }
      return valid_diagnostics[0] if valid_diagnostics.length == 1
    end
  end

  def self.most_frequent_bit(bit_index, valid_diagnostics)
    bits_from_column = all_bits_from_column(valid_diagnostics, bit_index)
    bits_from_column.count('0') > bits_from_column.count('1') ? '0' : '1'
  end

  def self.all_bits_from_column(valid_diagnostics, bit_index)
    valid_diagnostics.map(&:chars).transpose[bit_index]
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

  describe 'scrubber rating' do
    it "returns the one diagnostic, least matching the most frequent bits, from left to right" do
      diagnostics = %w(101 110 111 010 000)
      expect(LifeSupportCalculator.scrubber_rating(diagnostics)).to be('0'.to_i(2))
    end
  end

end

RSpec.describe "Calculating the life support from a real diagnostic" do

  it "resolves riddle sample" do
    diagnostic = File.readlines('./spec/Day03/sample.txt', chomp: true)
    expect(LifeSupportCalculator.oxygen_generator_rating(diagnostic)).to eq(23)
    expect(LifeSupportCalculator.scrubber_rating(diagnostic)).to eq(10)
  end

  it "resolves my personal riddle" do
    diagnostic = File.readlines('./spec/Day03/input.txt', chomp: true)
    expect(LifeSupportCalculator.oxygen_generator_rating(diagnostic) * LifeSupportCalculator.scrubber_rating(diagnostic)).to eq(4996233)
  end

end