require_relative '../spec_helper'

class BingoGame
  def initialize(number_sequence, boards)
    @number_sequence = number_sequence
    @boards = boards
  end

  def score
    drawn_numbers = []
    previous_winning_boards = []
    last_winning_score = 0
    @number_sequence.each do |number|
      drawn_numbers << number
      winning_boards = winning_boards_from(drawn_numbers)

      new_winners(previous_winning_boards, winning_boards).each do |winning_board|
        previous_winning_boards << winning_board
        last_winning_score = score_from(winning_board, drawn_numbers) * number
      end
    end
    last_winning_score
  end

  private

  def winning_boards_from(drawn_numbers)
    @boards.find_all { |board| has_winning_row?(board, drawn_numbers) || has_winning_column?(board, drawn_numbers) }
  end

  def new_winners(previous_winning_boards, winning_boards)
    winning_boards.select { |w| !previous_winning_boards.include?(w) }
  end

  def has_winning_row?(board, drawn_numbers)
    board.any?{|row| row.all?{|n| has_been_drawn?(n, drawn_numbers)}}
  end

  def has_winning_column?(board, drawn_numbers)
    board.transpose.any?{|column| column.all?{|n| has_been_drawn?(n, drawn_numbers)}}
  end

  def has_been_drawn?(n, drawn_numbers)
    drawn_numbers.include?(n)
  end

  def score_from(winning_board, drawn_numbers)
    winning_board.flatten.reject{|n| has_been_drawn?(n, drawn_numbers)}.sum
  end
end

class BingoInput
  attr_accessor :number_sequence
  attr_accessor :boards

  def initialize(number_sequence, boards)
    self.number_sequence = number_sequence
    self.boards = boards
  end


  def self.from(filename)
    lines = File.readlines(filename)
    boards = boards_from(lines)
    return BingoInput.new(number_sequence_from(lines), boards)
  end

  private

  def self.number_sequence_from(lines)
    lines[0].split(',').map(&:to_i)
  end

  def self.boards_from(lines)
    boards = []
    lines.drop(1).each_slice(6) do |board_lines|
      board = []
      board_lines.drop(1).each do |line|
        board << line.split(' ').map(&:to_i)
      end
      boards << board
    end
    boards
  end

end

RSpec.describe "Feature" do
  it "solves the sample riddle" do
    input = BingoInput.from('./spec/Day04/sample.txt')
    sample_game = BingoGame.new(input.number_sequence, input.boards)
    expect(sample_game.score).to be(1924)
  end

  it "solves my personal riddle" do
    input = BingoInput.from('./spec/Day04/input.txt')
    sample_game = BingoGame.new(input.number_sequence, input.boards)
    expect(sample_game.score).to be(15561)
  end
end

RSpec.describe BingoInput do

  it "return the number sequence to play with" do
    bingo_input = BingoInput.from('./spec/Day04/sample.txt')

    expect(bingo_input.number_sequence).to match_array([7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
  end

  it "returns the boards to play with" do
    bingo_input = BingoInput.from('./spec/Day04/sample.txt')

    expect(bingo_input.boards.length).to be(3)

    expect(bingo_input.boards[0].length).to be(5)
    expect(bingo_input.boards[0][0][0]).to be(22)
    expect(bingo_input.boards[0][4][4]).to be(19)
  end
end

RSpec.describe BingoGame do

  describe "a single winning board by row" do
    it "scores is the last number drawn * the sum of winning's board undrawn numbers" do
      bingo_game_new = BingoGame.new([22, 44, 19], [
        [[1,2],[3,4]],
        [[1,2],[3,4]],
        [[66,77],[22,44]]
      ])
      expect(bingo_game_new.score).to be(44 * (66 + 77))
    end
  end

  describe "a winning board by column" do
    it "scores is the last number drawn * the sum of winning's board undrawn numbers" do
      bingo_game_new = BingoGame.new([7, 8, 77], [
        [[1,2],[3,4]],
        [[7,2],[8,4]],
      ])
      expect(bingo_game_new.score).to be(8 * (2 + 4))
    end
  end

  describe "with two winners" do
    it "considers the last winner the true winner" do
      bingo_game_new = BingoGame.new([7, 8, 1, 2, 18], [
        [[1,2],
         [3,7]],

        [[7,2],
         [8,4]],
      ])
      expect(bingo_game_new.score).to eq(2 * (3))
    end
  end
end





