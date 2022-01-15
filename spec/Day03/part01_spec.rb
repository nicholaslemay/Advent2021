
class PowerCalculator
  def self.gamma_rate(diagnostic)
    diagnostic.to_i(2)
  end
end

RSpec.describe "Something" do

  it "gamma rate is the decimal value of the bits of the diagnostic" do
    diagnostic = '000010'
    expect(PowerCalculator.gamma_rate(diagnostic)).to eq(2)
  end
end