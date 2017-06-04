require('minitest/autorun')
require_relative('../lib/robot.rb')
require_relative('../lib/table.rb')

class TestRobot < Minitest::Test

    def test_true
        assert(true)
    end

    def test_robot_creation
      r=Robot.new
      assert(r!=nil)
    end

    def test_robot_left_rotation # test counterclockwise rotation: N-W-S-E-N
      r=Robot.new
      r.place(0,0,:NORTH)
      assert(r.direction==:NORTH)
      r.rotate_left
      assert(r.direction==:WEST)
      r.rotate_left
      assert(r.direction==:SOUTH)
      r.rotate_left
      assert(r.direction==:EAST)
      r.rotate_left
      assert(r.direction==:NORTH)
    end
    def test_robot_right_rotation # test clockwise rotation: N-E-S-W-N
      r=Robot.new
      r.place(0,0,:NORTH)
      assert(r.direction==:NORTH)
      r.rotate_right
      assert(r.direction==:EAST)
      r.rotate_right
      assert(r.direction==:SOUTH)
      r.rotate_right
      assert(r.direction==:WEST)
      r.rotate_right
      assert(r.direction==:NORTH)
    end
    def test_robot_movement_x_axis
      r=Robot.new
      r.place(0,0,:EAST)
      r.move
      assert(r.x==1)
      r.rotate_right
      r.rotate_right
      r.move
      assert(r.x==0) # must return to starting point
    end
    def test_robot_movement_y_axis
      r=Robot.new
      r.place(0,0,:NORTH)
      r.move
      assert(r.y==1)
      r.rotate_right
      r.rotate_right
      r.move
      assert(r.y==0) # must return to starting point
    end
    def test_robot_fall_from_table_must_be_prevented
      r=Robot.new
      r.place(0,0,:SOUTH)
      assert(r.x==0 && r.y==0)
      r.move
      assert(r.x==0 && r.y==0)
      r.rotate_right
      r.move
      assert(r.x==0 && r.y==0)
      r.place(4,4,:NORTH)
      r.move
      assert(r.x==4 && r.y==4)
      r.rotate_right
      r.move
      assert(r.x==4 && r.y==4)
    end
    def test_commands_before_place_should_be_ignored
      r=Robot.new
      r.move
    end
    def test_robot_that_is_not_on_the_table_should_ignore_commands
      r=Robot.new
      r.place(6,6,:NORTH)
      r.move
      assert(r.x==6 && r.y==6)
    end

end
