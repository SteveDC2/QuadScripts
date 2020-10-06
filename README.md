# QuadScripts

This PERL script will generate a Quad pick and place control file set.

Input files include...
1) Source CAD pick and place file
2) Component descriptions file
3) Feeder locations file
4) Nozzle pickup locations file

Test outputs can be generated to quickly check the placements and the pickup locations before generating full run files.

Pickup and place locations can be sorted by pickup nozzle, and by x/y location.

Report files are generated with component counts etc... which can also be sorted in various ways.

I have not managed to work out how to automatically generate the board directory name from the project name yet, so it is necessary to create a new project within the Quad's Central Control program to get the board directory name.

There are some constants that should be set that are specific to your machine. Specifically, the Z reference is VERY important to set correctly. Repeat.. VERY IMPORTANT. If you destroy your machine using these scripts I cannot be held responsible in any way !!!
Open PnPAutoGen.pl in a text editor and search for the following entries...
$QuadReferenceZNoLifter = 1180;
$QuadReferenceZLifter = 970;

If you have PCB lifters (and want to use them) then change both these settings, otherwise you can make them both the same. 
These settings are what the script will assume is effectively the BOTTOM height of the PCB and will base all calculations for Z-height from these.
Using your hand held terminal (HHT) pick a nozzle, then move the head to a location where it can be adjusted up and down to the Z-height where your PCB will be located.
If you do NOT have a PCB transport mechanism then this will simply be the bed where you put your PCB. If you do have a PCB transport mechanism then it will be the top of the transport belt for $QuadReferenceZNoLifter. $QuadReferenceZLifter can be a little more difficult to measure but will be the top of the lifter pins when they are activated. I personally never used the lifters so play with this at your own risk.

Note : Setting a good/correct Z-height is CRITICAL to getting a good placement. If you do not get this set correctly then you risk components either not getting puched in to the solder paste, or of components bouncing as the PCB flexes.

## Command line arguments
 -width xxxx        : Board width in board units (Altium = mils, KiCad = mm)  
 -height xxxx       : Board height in board units (Altium = mils, KiCad = mm)  
 -thick xxxx        : Board thicknes in mils  
 -input abcd.pnp    : Input pick and place filename  
 -name BOARDNAME    : Board name  
 -quad BRDxxxxx.dir : Quad assigned board directory name  
 -side [T/B]        : Board side to process, default top  
 -vision [Y/N]      : Pause after initial sequence to allow vision position to be checked  
 -format xxxx       : Pick file format (altium or kicad, defalut altium)  
 -feeder abcd.txt   : Feeder location file  
 -x xxxx            : Global placement x offset  
 -y yyyy            : Global placement y offset  
 -z yyyy            : Global placement z offset  
 -putest [Y/N]      : Genertate test pickup of all components in feeder location file  
 -comptest [Y/N/M]  : Generate test pickup and place for each different component in PnP file. Front left most component positions used. 'M' uses BOARDNAME, 'Y' uses 'COMPONENTTEST, BRD60FXX.DIR'  
 -sort [F/P]        : Select report file list sort order. 'F' sorts by feeder, 'P' sorts by pickup count  
 -lifter [Y/N]      : Lift PCB after transport feed  
 -xscale xxxx       : Global placement x scale factor  
 -yscale xxxx       : Global placement y scale factor  


An example command line is as follows...

perl PnPAutoGen.pl -input "D:\Hardware Projects\CableSwitcher\Project Outputs\Pick Place Output\Pick Place for SwitcherSimple-3xPanel.txt" -thick 48 -width 6142 -height 3937 -name Switcher -quad BRD345xx.dir -feeder FeederPickupSwitcher.txt -y 1 -x 1

## Nozzle 'chuck' file
Pickup nozzle locations are specified in the file "Chucks.txt". Parameters are X, Y, Z, description with each parameter seperated with <TAB>.
e.g.  
25162	20631	1120	Tiny-N  
25845	20624	1120	Small-N  
26664	20624	1120	Big-R  
25155	19426	1120	Large-N  
25864	19418	1105	Medium-R  
26662	19427	1120	Huge-R  

## Component locations and feeder
Components and feeder locations are specified in a combination of 2 files. This allows your components database to be independent of the feeders to some degree and have project specific component and feeder locations.

"ComponentFeeders.txt"  
This file contains information about each component size, which feeder ID (name) to use and the placement orientation (theta) offset. For components in a 'waffle' area this file also contains the x-step and y-step distances for the components.
I recommend keeping all your component data in an Excel file then simply selecting the data and pasting into a text editor then save as "ComponentFeeders.txt". This will generate a tab seperated text file but allow much cleaner/readable structure in the Excel file. This also allows the Excel file to contain data for multiple projects and you can just copy what is necessary for the current project.Take a look at my examples to clarify just what I mean.

"FeederPickupxxxxx.txt"  
Feeder pickup files contain machine centric pickup locations and assigns each location a name to be used by "ComponentFeeders.txt"

Note : FeederPickupReels.txt will be loaded if present in addition to any specified feeder file. I used this for common components which were always on my machine.

The Feeder files contain a feeder name, x, y & Z position, orientation (theta. I recommend setting this to 0 and making orientation changes in the ComponentFeeder file), rows, columns , description each <TAB> seperated. The feeder name is used as a key by the components file to select a pickup locatin.

So, I know some of the information seems spread across 2 different files but I just never got around to cleaning things up. Sorry.

### Pick up test  
The command line argument "-putest Y" will generate a board file set that will move the head to each of the pickup locations in turn. This should be executed with the HHT in single step mode and the downward facing camera to check each pickup location is corerctly defined.

### Component test
The command line argument "-comptest Y" will generate a board file set that has one and only one of each component. This can be used to quickly test that all component sizes, pickup locations and orientations are corerct.  

I recommend covering a test PCB with double sided tape and running this test. If any components are not placed with the correct orientation than update the theta setting in the components feeder XLS/txt files.

Don't use the "M" option. I can't recall what is does :)

## Vision
Vision fiducials are supported, but they need to be manually configured.  
Generate a board set with the component test and transfer to your machine, then go through the fiducal learing process to teach fiducial points. 

Next, test step the program with the HHT so that the head moves over each placement. Keep stepping until a small component is being 'placed' and try to gauge how "wrong" the placement is.   
For example if the head looks to be off by 20 mil in x and 8 mil in y then note 20 & 8.  

Regenerate the files but not 'correct' the placement with the -x & -y parameters.

Repeat the adjustments until the placement is good.

Finally, remove the component test option and re-generate the board files.

## WARNINGS!!!
So, this is a project I created to help myself. I make absolutely no guarantees about the performance of the script or its ability to destroy your Quad !!!

USE AT YOUR OWN RISK!!!

I certainly recommend single stepping any board control files without a nozzle present initially since those suckers are delicate !!!
