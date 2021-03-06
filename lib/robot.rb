require_relative('table.rb')
require_relative('command.rb')

class Robot
  attr_accessor :x,:y,:direction,:table
  DIRECTIONS=[:NORTH,:EAST,:SOUTH,:WEST]

  def place(x,y,direction)
    return unless DIRECTIONS.include?(direction)
    table=Table.new
    return unless x.between?(0,table.X-1) && y.between?(0,table.Y-1)
    @x=x
    @y=y
    @direction=direction
    @table=table
  end

  def move()
    return unless is_placed
    next_x=@x
    next_y=@y
    case @direction
    when :EAST
      next_x=@x+1
    when :WEST
      next_x=@x-1
    when :NORTH
      next_y=@y+1
    when :SOUTH
      next_y=@y-1
    end
    if check_edge(next_x,next_y)
      then
        @x=next_x
        @y=next_y
    end
  end

  def rotate_right()
    return unless is_placed
    current_dir_index=DIRECTIONS.index(@direction)
    if current_dir_index+1==DIRECTIONS.length then new_index=0
    else new_index=current_dir_index+1
    end
    @direction=DIRECTIONS[new_index]
  end

  def rotate_left()
    return unless is_placed
    current_dir_index=DIRECTIONS.index(@direction)
    if current_dir_index==0 then new_index=DIRECTIONS.length-1
    else new_index=current_dir_index-1
    end
    @direction=DIRECTIONS[new_index]
  end

    def check_edge(next_x,next_y) # returns true if movement should be allowed
      if next_x<@table.X &&
        next_x>=0 &&
        next_y<@table.Y &&
        next_y>=0 then return true
      else return false
      end
    end

    def report()
      return unless is_placed
      str=@x.to_s+','+@y.to_s+','+@direction.to_s
      puts str
      return str
    end

    def execute(command)
      return unless command.kind_of?Command
      case command
      when CommandPlace
        place(command.x,command.y,command.direction)
      when CommandMove
        move
      when CommandLeft
        rotate_left
      when CommandRight
        rotate_right
      when CommandReport
        report
      end
    end

    def is_placed
      return @table!=nil
    end
end
