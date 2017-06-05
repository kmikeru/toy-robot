require "command"

describe Command do
  describe "from_string" do
    it "parses commands without arguments" do
      expect(Command.from_string('MOVE')).to be_an_instance_of(CommandMove)
      expect(Command.from_string('LEFT')).to be_an_instance_of(CommandLeft)
      expect(Command.from_string('RIGHT')).to be_an_instance_of(CommandRight)
      expect(Command.from_string('REPORT')).to be_an_instance_of(CommandReport)
    end
    it "parses command with arguments" do
      expect(Command.from_string('PLACE 1,2,NORTH')).to be_an_instance_of(CommandPlace)
      expect(Command.from_string('PLACE 1,2,NORTH').x).to eq(1)
      expect(Command.from_string('PLACE 1,2,NORTH').y).to eq(2)
      expect(Command.from_string('PLACE 1,2,NORTH').direction).to eq(:NORTH)
    end
  end
end
