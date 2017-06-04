# Toy Robot Simulator

### Description:
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5
units x 5 units. There are no other obstructions on the table surface. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

### Running:
*Unit tests:*

ruby test/test_robot.rb

*With test data:*

cat test_input_a.txt | ruby lib/runner.rb 

Expected output:

0,1,NORTH

cat test_input_b.txt | ruby lib/runner.rb

Expected output:

0,0,WEST

cat test_input_c.txt | ruby lib/runner.rb 

Expected output:

3,3,NORTH

