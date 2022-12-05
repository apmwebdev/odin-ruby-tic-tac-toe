# frozen_string_literal: true

class Player
  attr_accessor :name, :goes_first, :turns_taken, :is_winner, :symbol

  def initialize(name)
    @name = name
    @goes_first = false
    @turns_taken = 0
    @is_winner = false
    @symbol = ''
  end

  def to_s
    "name: #{name}, goes_first: #{goes_first}, turns_taken: #{turns_taken}, is_winner: #{is_winner}"
  end
end