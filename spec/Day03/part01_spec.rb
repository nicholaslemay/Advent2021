
class PowerCalculator
  def self.gamma_rate
    0
  end
end

RSpec.describe "Something" do
  it "has default gamma rate" do
    expect(PowerCalculator.gamma_rate).to eq(0)
  end
end