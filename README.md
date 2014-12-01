LEDesic
=======

Software for controlling a geodesic dome covered with LEDs. Makes use of fadecandy and Open Pixel Control.

### Get started

1. Run DomeSim_Touchdesigner/DomeSim.toe - this will start a OPC server on port 7890.
	This is a TouchDesigner application and it requires Windows. There is a free non-commercial version, or the TouchPlayer runtime. Download and install: https://www.derivative.ca/088/Downloads

2. Run Dome_Calibration - this generates content and sends it to the server, using the fadecandy OPC libraries. This part is processing, it runs everywhere, get it at https://processing.org/

You should now have a simulated LED dome. Much easier than building a real one from scratch! You can use the calibration app to generate various content, it gets sent to 127.0.0.1 7890 as OPC data. That is where TouchDesigner is listeneing, and interprets that OPC data rendered in 3D.

All the geometry for this is specific to our LEDesic dome project, but there is no reason you couldn't load in your own points and visualize alternate geometries.

### To warp Processing content for the dome

1. Put LED\_config.pde in your Processing project
2. Find the size( call near the top and change the height and width to 450
	size(450, 450<there might be another arg here>)
3. Find the line: opc = new OPC(this, "127.0.0.1", 7890);
	Remove everything after this line to the end of the setup()
4. Replace with:
	LED_config(opc);

### Contents

* Dome\_Calibration - test patterns and a dome geometry mapping file
* DomeCalc - use this to generate 2D processing config files
* DomeSim\_TouchDesigner - visualiser for OPC data, includes 3D dome mapping
* Fadecandy_Sequencer - this lovely tool from fadecandy with an example of the dome geometry config
* Resources - 3D files and tidbits
* ThreeDDomeCalc - This generates the 3D geometry (points.txt) used by DomeSim to render the virtual dome.

Credits:
Fadecandy - I use some of their code, it is referenced here, and their 
hardware is pretty slick, we are using that too.
https://github.com/scanlime/fadecandy

Colin Worf started the LEDesic project and inspired the ideas contained here. Website/plug/kickstarter coming soon.

I am Tim Greiser aka ir8prim8. Thanks to my partner Amanda for her ideas and support on this project.  
ir8 [at] prim8.net  
http://prim8.net/  
http://www.youtube.com/user/AuralFixationMT/videos
