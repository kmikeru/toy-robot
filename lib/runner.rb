require_relative './robot.rb'

r=Robot.new
$stdin.each_line do |line|
  r.execute(line.chomp)
end
