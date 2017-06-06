require "robot"

describe Robot do
  it "executes PLACE command" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 1,1,NORTH'))
    expect(r.x).to eq(1)
    expect(r.y).to eq(1)
    expect(r.direction).to eq(:NORTH)
  end
  it "executes MOVE command" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 1,1,NORTH'))
    r.execute(Command.from_string('MOVE'))
    expect(r.x).to eq(1)
    expect(r.y).to eq(2)
    expect(r.direction).to eq(:NORTH)
  end

  it "executes LEFT command" do # test N-W-S-E-N rotation
    r=Robot.new
    r.execute(Command.from_string('PLACE 0,0,NORTH'))
    expect(r.direction).to eq(:NORTH)
    r.execute(Command.from_string('LEFT'))
    expect(r.direction).to eq(:WEST)
    r.execute(Command.from_string('LEFT'))
    expect(r.direction).to eq(:SOUTH)
    r.execute(Command.from_string('LEFT'))
    expect(r.direction).to eq(:EAST)
    r.execute(Command.from_string('LEFT'))
    expect(r.direction).to eq(:NORTH)
  end
  it "executes RIGHT command" do # test N-E-S-W-N rotation
    r=Robot.new
    r.execute(Command.from_string('PLACE 0,0,NORTH'))
    expect(r.direction).to eq(:NORTH)
    r.execute(Command.from_string('RIGHT'))
    expect(r.direction).to eq(:EAST)
    r.execute(Command.from_string('RIGHT'))
    expect(r.direction).to eq(:SOUTH)
    r.execute(Command.from_string('RIGHT'))
    expect(r.direction).to eq(:WEST)
    r.execute(Command.from_string('RIGHT'))
    expect(r.direction).to eq(:NORTH)
  end

  it "ignores commands before PLACE command" do
    r=Robot.new
    r.execute(Command.from_string('MOVE'))
    r.execute(Command.from_string('PLACE 0,0,NORTH'))
    expect(r.x).to eq(0)
    expect(r.y).to eq(0)
    expect(r.direction).to eq(:NORTH)
  end

  it "ignores PLACE command if starting point is not on the table" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 10,10,NORTH'))
    expect(r.is_placed).not_to eq(true)
    r.execute(Command.from_string('PLACE 5,5,NORTH'))
    expect(r.is_placed).not_to eq(true)
    r.execute(Command.from_string('PLACE -5,-5,NORTH'))
    expect(r.is_placed).not_to eq(true)
  end
  it "successfuly performs testcase a" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 0,0,NORTH'))
    r.execute(Command.from_string('MOVE'))
    res=r.execute(Command.from_string('REPORT'))
    expect(res).to eq('0,1,NORTH')
  end
  it "successfuly performs testcase b" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 0,0,NORTH'))
    r.execute(Command.from_string('LEFT'))
    res=r.execute(Command.from_string('REPORT'))
    expect(res).to eq('0,0,WEST')
  end

  it "successfuly performs testcase c" do
    r=Robot.new
    r.execute(Command.from_string('PLACE 1,2,EAST'))
    r.execute(Command.from_string('MOVE'))
    r.execute(Command.from_string('MOVE'))
    r.execute(Command.from_string('LEFT'))
    r.execute(Command.from_string('MOVE'))
    res=r.execute(Command.from_string('REPORT'))
    expect(res).to eq('3,3,NORTH')
  end

end
