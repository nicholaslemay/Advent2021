require_relative '../../spec_helper'
require_relative 'day10_spec'

class AutoCompletionScore
  POINTS = { '>' => 4, '}' => 3, ']' => 2, ')' => 1 }

  def self.score_for(string)
    string.chars.reduce(0) { |sum, c| sum * 5 + POINTS[c] }
  end
end

class AutoComplete
  EXPECTED_CLOSING_MATCHES = { '<' => '>', '(' => ')', '{' => '}', '[' => ']' }

  def self.line(line)
    opened_characters = []
    line.chars.each do |new_character|
      if (new_character == EXPECTED_CLOSING_MATCHES[opened_characters.last])
        opened_characters.pop
      else
        opened_characters << new_character
      end
    end
    opened_characters.reverse.map { |c| EXPECTED_CLOSING_MATCHES[c] }.join
  end
end

RSpec.describe "AutoComplete Score " do
  it 'autocomplete incomplete lines' do
    expect(AutoCompletionScore.score_for('}}]])})]')).to eq(288957)
    expect(AutoCompletionScore.score_for(')}>]})')).to eq(5566)
    expect(AutoCompletionScore.score_for('}}>}>))))')).to eq(1480781)
    expect(AutoCompletionScore.score_for(']]}}]}]}>')).to eq(995444)
    expect(AutoCompletionScore.score_for('])}>')).to eq(294)
  end
end

RSpec.describe "AutoComplete" do

  it 'autocomplete incomplete lines' do
    expect(AutoComplete.line('<')).to eq('>')
    expect(AutoComplete.line('(')).to eq(')')
    expect(AutoComplete.line('{')).to eq('}')
    expect(AutoComplete.line('[')).to eq(']')
    expect(AutoComplete.line('<<<')).to eq('>>>')

    expect(AutoComplete.line('<()')).to eq('>')
    expect(AutoComplete.line('[({(<(())[]>[[{[]{<()<>>')).to eq('}}]])})]')
  end
end

RSpec.describe "Day 10 part 02" do

  it 'solves the sample' do
    scores = File.readlines('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/sample.txt', chomp: true)
                           .select { |l| Compiler.missing_char(l) == nil }
                           .map { |l| AutoComplete.line(l) }
                           .map { |l| AutoCompletionScore.score_for(l) }
                           .sort

    expect(scores[scores.length/2]).to eq(288957)
  end

  it 'solves the riddle' do
    scores = File.readlines('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/input.txt', chomp: true)
                 .select { |l| Compiler.missing_char(l) == nil }
                 .map { |l| AutoComplete.line(l) }
                 .map { |l| AutoCompletionScore.score_for(l) }
                 .sort

    expect(scores[scores.length/2]).to eq(2924734236)
  end
end