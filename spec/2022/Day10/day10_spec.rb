require_relative '../../spec_helper'

class Compiler
  OPENING_CHARS = %w|< ( { [|
  EXPECTED_CHARACTER_PAIRS = { '<' => '>', '(' => ')', '{' => '}', '[' => ']'}

  def self.missing_char(line)
    opened_characters = []
    line.chars.each do |new_character|
      if OPENING_CHARS.include?(new_character)
        opened_characters << new_character
      else
        return new_character if new_character != EXPECTED_CHARACTER_PAIRS[opened_characters.pop]
      end
    end
    nil
  end
end

RSpec.describe "Day 01" do

  points = {')' => 3,
            ']' => 57,
            '}' => 1197,
            '>' => 25137}

  it "solves the sample riddle" do
    expect(Compiler.missing_char('<{([([[(<>()){}]>(<<{{')).to eq('>')
    expect(Compiler.missing_char('[[<[([]))<([[{}[[()]]]')).to eq(')')
    expect(Compiler.missing_char('[{[{({}]{}}([{[{{{}}([]')).to eq(']')
    expect(Compiler.missing_char('[<(<(<(<{}))><([]([]()')).to eq(')')
    expect(Compiler.missing_char('<{([([[(<>()){}]>(<<{{')).to eq('>')

    expect(Compiler.missing_char('[({(<(())[]>[[{[]{<()<>>')).to eq(nil)
    expect(Compiler.missing_char('[(()[<>])]({[<{<<[]>>(')).to eq(nil)
  end

  it 'solves the sample' do
    calculated_score = File.readlines('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/sample.txt', chomp:true)
                           .map { |l| Compiler.missing_char(l) }
                           .compact
                           .sum { |c| points[c] }
    expect(calculated_score).to eq(26397)
  end

  it 'solves the riddle' do
    calculated_score = File.readlines('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/input.txt', chomp:true)
                           .map { |l| Compiler.missing_char(l) }
                           .compact
                           .sum { |c| points[c] }
    expect(calculated_score).to eq(343863)
  end

end