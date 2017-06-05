class Command
  def self.from_string(string)
    case string
    when /PLACE\s(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)/
      place=string.scan(/PLACE\s(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)/)
      x=place[0][0].to_i
      y=place[0][1].to_i
      direction=place[0][2].to_sym
      return CommandPlace.new(x,y,direction)
    when 'MOVE'
      return CommandMove.new
    when 'LEFT'
      return CommandLeft.new
    when 'RIGHT'
      return CommandRight.new
    when 'REPORT'
      return CommandReport.new
    end
  end
end

class CommandPlace < Command
  attr_accessor :x,:y,:direction
  def initialize(x,y,direction)
    @x=x
    @y=y
    @direction=direction
  end
end

class CommandMove < Command
end

class CommandLeft < Command
end

class CommandRight < Command
end

class CommandReport < Command
end
