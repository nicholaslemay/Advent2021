
class PowerCalculator
  def self.gamma_rate(diagnostic_entries)
    most_frequent_bits = ''
    bits_grouped_together = diagnostic_entries.map(&:chars).transpose
    bits_grouped_together.select do |bits|
      most_frequent_bits += bits.max_by { |i| bits.count(i) }
    end
    most_frequent_bits.to_i(2)
  end

  def self.epsilon_rate(diagnostic_entries)
    self.gamma_rate(diagnostic_entries) ^ '11111'.to_i(2)
  end
end

RSpec.describe "PowerCalculator" do

  it "gamma rate is the decimal value of the most frequents bits of each entry of the diagnostic" do
    diagnostic = %w[00010 00011 00001]
    expect(PowerCalculator.gamma_rate(diagnostic)).to eq(3)
  end

  it "epsilon rate is the decimal value of the most infrequent bits of each entry of the diagnostic" do
    diagnostic = %w[10101]
    expect(PowerCalculator.epsilon_rate(diagnostic)).to eq('01010'.to_i(2))
  end
end


RSpec.describe "Calculating power from a real diagnostic" do
  it "resolves riddle sample" do
    diagnostic = File.readlines('./spec/Day03/sample.txt', chomp: true)
    expect(PowerCalculator.epsilon_rate(diagnostic)).to eq(9)
    expect(PowerCalculator.gamma_rate(diagnostic)).to eq(22)
  end
end