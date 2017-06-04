require_relative('table.rb')
class Robot
  attr_accessor :x,:y,:direction,:table
  DIRECTIONS=[:NORTH,:EAST,:SOUTH,:WEST]

  def place(x,y,direction)
    @x=x
    @y=y
    return unless DIRECTIONS.include?(direction)
    @direction=direction
    @table=Table.new
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
      puts @x.to_s+','+@y.to_s+','+@direction.to_s
    end

    def execute(command)
      case command
      when /^PLACE\s.*/
        execute_place_cmd(command)
      when 'MOVE'
        move
      when 'LEFT'
        rotate_left
      when 'RIGHT'
        rotate_right
      when 'REPORT'
        report
      end
    end

    def execute_place_cmd(command)
      place=command.scan(/PLACE\s(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)/)
      if place!=[] && place[0].size==3 then
        x=place[0][0].to_i
        y=place[0][1].to_i
        direction=place[0][2].to_sym
        place(x,y,direction)
      end
    end

    def is_placed
      return @table!=nil
    end
end
