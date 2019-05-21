require 'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(6) {Array.new([:stone, :stone, :stone, :stone])} + Array.new(1) {Array.new} + Array.new(6) {Array.new([:stone, :stone, :stone, :stone])} + Array.new(1) {Array.new}
  end
  

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12
      raise "Invalid starting cup"
    end

    if @cups[start_pos].empty?
      raise "Starting cup is empty"
    end
  end

  def make_move(start_pos, current_player_name)
    stones_array = @cups[start_pos]
    @cups[start_pos] = []

    idx = start_pos
    until stones_array.empty?
      idx += 1
      idx = 0 if idx > 13
      if idx == 6
        @cups[6] << stones_array.pop if current_player_name == @name1
      elsif idx == 13
        @cups[13] << stones_array.pop if current_player_name == @name2
      else
        @cups[idx] << stones_array.pop
      end
    end

    render
    next_turn(idx)
  end

  #if empty -> return switch
  #if on current player cup -> return prompt

  def next_turn(ending_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_idx
    # debugger
    if ending_idx.between?(0, 5) || ending_idx.between?(7, 12)
      if @cups[ending_idx].size == 1
        ending_idx
      else
        :switch
      end
    elsif [6, 13].include?(ending_idx)
      :prompt
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..6).all? { |i| @cups[i].empty? } || (7..12).all? { |i| @cups[i].empty? }
  end

  def winner
    return :draw if @cups[6].size == @cups[13].size

    @cups[6].size > @cups[13].size ? @name1 : @name2
  end
end
