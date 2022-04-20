require_relative '../../spec_helper'
require_relative 'day10_spec'

class AutoCompletionScoreCalculator
  def self.score_for(file)
    scores = AutoComplete.lines(File.readlines(file, chomp: true))
                         .map { |l| AutoCompletionScore.score_for(l) }
                         .sort
    scores[scores.length/2]
  end
end

class AutoComplete
  CLOSING_CHARS_FOR_OPENING_CHARACTER = { '<' => '>', '(' => ')', '{' => '}', '[' => ']' }

  def self.lines(lines)
    lines.map do |l|
      AutoComplete.line(l)
      rescue InvalidLine
    end.compact
  end

  def self.line(line)
    opened_characters = []
    line.chars.each do |new_character|
      if CLOSING_CHARS_FOR_OPENING_CHARACTER.key?(new_character)
        opened_characters << new_character
      elsif new_character == CLOSING_CHARS_FOR_OPENING_CHARACTER[opened_characters.last]
        opened_characters.pop
      else
        raise InvalidLine
      end
    end
    opened_characters.reverse.map { |c| CLOSING_CHARS_FOR_OPENING_CHARACTER[c] }.join
  end

  class InvalidLine < Exception; end
end

class AutoCompletionScore
  def self.score_for(missing_characters)
    points = { '>' => 4, '}' => 3, ']' => 2, ')' => 1 }
    missing_characters.chars.reduce(0) { |sum, c| sum * 5 + points[c] }
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
    score = AutoCompletionScoreCalculator.score_for('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/sample.txt')
    expect(score).to eq(288957)
  end

  it 'solves the riddle' do
    score = AutoCompletionScoreCalculator.score_for('/Users/nick/RubymineProjects/Advent2021/spec/2022/Day10/input.txt')
    expect(score).to eq(2924734236)
  end
end