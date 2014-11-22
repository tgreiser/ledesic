LEDesic
=======

Software for controlling a geodesic dome covered with LEDs. Makes use of fadecandy and Open Pixel Control.

### Processing

1. Put LED_config.pde in your Processing project
2. Find the size( call near the top and change the height and width to 450
	size(450, 450<there might be another arg here>)
3. Find the line: opc = new OPC(this, "127.0.0.1", 7890);
	Remove everything after this line to the end of the setup()
4. Replace with:
	LED_config(opc);
