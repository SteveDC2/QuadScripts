#!/usr/bin/perl
use File::Path;
#Ver 1.6 October 6th 2016
#Various reporting changes
#Added -sort command line option

#Ver 1.5 June 18th 2016
#Various reporting changes
#Added "HAND" as a feeder option
#putest uses fixed name and DIR so doesn't corrupt real board when copied to Quad

#Ver 1.4 May 18th 2016
#Added KiCad format reading
#Ver 1.3 March 9th 2012
#Added chuck priority sorting
#Added SKIP option for feeder
#Ver 1.2 Oct 23rd 2011
#Added head1.set file for multi part designs
#Added delete of directory to ensure clean database

#Board settings...

#Ace lite RCP boards for Revision 1.1 emulator
#-input "D:\Hardware Projects\AceLite\Project Outputs\Pick Place Output\Pick Place for RCP_PP_For_Rev2.0_EVM - Set.txt" -thick 35 -width 3750 -height 5750 -name RCP1_1 -quad BRD316xx.dir -format Altium -feeder FeederPickupSwitcher.txt -x -135 -y 175 -vision y -comptest n -side T -xscale 1.011 -yscale 1.003

#Ace lite RCP boards for Revision 1.0 emulator
#-input "D:\Hardware Projects\AceLite\Project Outputs\Pick Place Output\Pick Place for RCP_PP_For_Rev1.0_EVM.txt" -thick 35 -width 3750 -height 5750 -name RCP1_0 -quad BRD317xx.dir -format Altium -feeder FeederPickupSwitcher.txt -x -157 -y 0 -vision y -comptest n -side T -xscale 1.011 -yscale 1.003

#Pick and place for Zensio Environmental panel array - base + noise + air quality configuration
#-input "D:\Hardware Projects\Zenseio\Boards\Environmental Module1\EnvironmentalSetBaseNoiseAQRotated.txt" -thick 53 -width 7874 -height 3700 -name ZensioEnvironmentalBaseNoiseAQ -quad BRD7dbxx.dir -format Altium -feeder FeederPickupZensioMB_Environmental.txt -x -8 -y 9 -vision y -comptest n -side T

#Pick and place for Zensio Environmental panel array - base + noise configuration
#-input "D:\Hardware Projects\Zenseio\Boards\Environmental Module1\EnvironmentalSetBaseNoiseRotated.txt" -thick 53 -width 7874 -height 3700 -name ZENZIOENVIRONMENTALBASENOISE -quad BRD9a2xx.dir -format Altium -feeder FeederPickupZensioMB_Environmental.txt -x -8 -y 9 -vision y -comptest n -side T

#Pick and place for Zensio Environmental panel array - base configuration
#-input "D:\Hardware Projects\Zenseio\Boards\Environmental Module1\EnvironmentalSetBaseRotated.txt" -thick 53 -width 7874 -height 3700 -name ZensioEnvironmentalBase -quad BRD5bbxx.dir -format Altium -feeder FeederPickupZensioMB_Environmental.txt -x -8 -y 9 -vision y -comptest n -side T

#Pick and place for Zensio Battery panel array
#-input "D:\Hardware Projects\Zenseio\Boards\BatteryModule\Panel-top.pos" -thick 53 -width 94 -height 200 -name ZensioBattery -quad BRD321xx.dir -format KiCad -feeder FeederPickupZensioMB_GPS_BATTERY.txt -x -3 -y -350 -vision y -comptest n -side T

#Pick and place for Zensio GPS panel array
#-input "D:\Hardware Projects\Zenseio\Boards\GPS\Panel-bottom.pos" -thick 53 -width 206 -height 283 -name ZensioGPS -quad BRD2C6xx.dir -format KiCad -feeder FeederPickupZensioMB_GPS.txt -y -3614 -x 0 -vision y -comptest n -side B

#Pick and place for Zensio main board panel array top
#-input "D:\Hardware Projects\Zenseio\Boards\Main panel array\Modular - panel-top.pos" -thick 53 -width 206 -height 283 -name ZensioMB -quad BRD2d5xx.dir -format KiCad -feeder FeederPickupZensioMB_Environmental_ThinGuide.txt -y 7 -x 199 -side T -vision y -putest N -comptest N

#Pick and place for Zensio main board panel array bottom
#-input "D:\Hardware Projects\Zenseio\Boards\Main panel array\Modular - panel-bottom_manual.pos" -thick 53 -width 206 -height 283 -name ZensioMBBottom -quad BRD4B0xx.dir -format KiCad -feeder FeederPickupZensioMB_Environmental_New.txt -y 2 -x -212 -side B -vision y -putest N -comptest N

#Pick and place for Zensio main board single
#-input "D:\Hardware Projects\Zenseio\Boards\Main single\Modular-top.pos" -thick 63 -width 96 -height 55 -name ZensioMB -quad BRD2d5xx.dir -format KiCad -feeder FeederPickupZensioMB.txt -y 28 -x 3

#File for USB Type-C simple switcher simple
#-input "D:\Hardware Projects\CableSwitcher\Project Outputs\Pick Place Output\Pick Place for SwitcherSimple-3xPanel.txt" -thick 48 -width 6142 -height 3937 -name Switcher -quad BRD345xx.dir -feeder FeederPickupSwitcher.txt -y 1 -x 1

#File for USB Type-C simple switcher monitor
#-input "D:\Hardware Projects\CableSwitcherMonitor\Project Outputs\Pick Place Output\Pick Place for SwitcherSimpleMonitor-3xPanel.txt" -thick 48 -width 6142 -height 3937 -name Switcher -quad BRD345xx.dir -feeder FeederPickupSwitcher.txt -y 1 -x -7 -vision Y -comptest n

#Pick and place for John's Nixie
#Board name = "NIXIE"
#-input "source\Pick Place for NIXIE.txt" -thick 53 -width 7470 -height 3560 -feeder FeederPickupnIXIE.txt -name NIXIE -quad BRD187XX.DIR -x 1370 -y -554

#Pick and place controller board
#Board name = "STEPPER"
#-input "source\Pick Place for PNP Driver Board.txt" -thick 63 -width 7470 -height 3560 -feeder FeederPickupCMX.txt -name STEPPER -quad BRD313XX.DIR -x 8 -y 6

#CMX3838V2
#Board name = "CMX3838PQFP"
#Thicknes includes support board
#-input "source\Pick Place for CMX3838V2 PQFP.txt" -thick 100 -width 8606 -height 9155 -feeder FeederPickupCMX.txt -name CMX3838PQFP -quad BRD385XX.DIR -x 200 -y -8

#Board name = "CMX3838AUDIO"
#-input "source\Pick Place for CMX3838V2 AudioCpu.txt" -thick 100 -width 8602 -height 8952 -feeder FeederPickupCMX.txt -name CMX3838AUDIO -quad BRD4DEXX.DIR
 
#Board name = "CMX3838BGA"
#-input "source\Pick Place for BGA Main PnP set.txt" -thick 100 -width 8605 -height 9155 -feeder FeederPickupCMX.txt -name CMX3838BGA -quad BRD36EXX.DIR -x 204 -y 6

#CMX 3x ADI audio output
#-y -104 -x 2 -input "source\Pick Place for 3x AnalogOut.txt" -thick 63 -width 7560 -height 7325 -feeder FeederPickupCMX.txt -name ADIX3 -quad BRD209XX.DIR

#CMX waffle component check
#-input "source\Pick Place for Component check.txt" -thick 63 -width 3040 -height 3920 -feeder FeederPickupCMX.txt -name CMXCHECK -quad BRD2E8XX.DIR

#CMX full set
#-input "source\Pick Place for CompleteSet.txt" -thick 63 -width 17107 -height 8605 -feeder FeederPickupCMX.txt -name CMX -quad BRD1EEXX.DIR

#CMX full set pick test
#-input "source\Pick Place for CompleteSet.txt" -thick 63 -width 17107 -height 8605 -feeder FeederPickupCMX.txt -name CMXCHECK -quad BRD2e8XX.DIR -putest Y 

#CMX IO
#-input "source\Pick Place for IOSetforPnP.txt" -thick 63 -width 8605 -height 8290 -feeder FeederPickupCMX.txt -name CMXIO -quad BRD1AAXX.DIR

#CMX MAIN
#-input "source\Pick Place for MainSetforPnP.txt" -thick 63 -width 8605 -height 8715 -feeder FeederPickupCMX.txt -name CMXMAIN -quad BRD211XX.DIR -x +2 -y -3

#Convert data to AutoProg
#-input "source\Pick Place for SlaveBoard V5b.txt" -height 9157 -autoprog Y

#Teeny x4
#Board name = "JAILBREAK"
#-height 2331 -width 3144 -input "source\Pick Place for Teenyx4.txt" -thick 63 -quad BRD2B7XX.DIR -feeder "FeederPickupReceivers.txt"

#Pickup test sequence
#Board name = "PUTEST"
#-width 100 -height 100 -input dummy -thick 0 -putest Y -quad BRD2ACXX.DIR -name PICKUPTEST

#Power and control
#"POWERANDCONTROL"
#-name POWERANDCONTROL -width 4725 -height 3810 -input "source\Pick Place for PowerAndControlBoard.txt" -thick 63 -quad BRD5E7XX.DIR -feeder "FeederPickupPowerAndControl.txt"

#Slave board
#-width 6680 -height 9157 -input "source\Pick Place for SlaveBoard V6.txt"  -thick 63 -feeder "FeederPickupMain.txt"
#Board name = "SLAVE-1"
#-width 6680 -height 9157 -input "source\Pick Place for SlaveBoard V6-1.txt"  -thick 63 -quad BRD1c1XX.DIR -feeder "FeederPickupMain.txt"
#Board name = "SLAVE-2"
#-width 6680 -height 9157 -input "source\Pick Place for SlaveBoard V6-2.txt"  -thick 63 -quad BRD1c8XX.DIR -feeder "FeederPickupMain.txt"

#Main board
#Board name = "MAINBOARD"
#-width 8360 -height 9157 -input "source\Pick Place for MainBoard V5.txt" -thick 63 -feeder "FeederPickupMain.txt"
#Board name = "MAIN-1"
#-name MAIN-1 -width 8360 -height 9157 -input "source\Pick Place for MainBoard V5-1.txt" -thick 63 -quad BRD27fXX.DIR -feeder "FeederPickupMain.txt"
#Board name = "MAIN-2"
#-name MAIN-2 -width 8360 -height 9157 -input "source\Pick Place for MainBoard V5-2.txt" -thick 63 -quad BRD27aXX.DIR -feeder "FeederPickupMain.txt"
#Board name = "MAIN-2"
#-name MAIN-3 -width 8360 -height 9157 -input "source\Pick Place for MainBoard V5-3.txt" -thick 63 -quad BRD27dXX.DIR -feeder "FeederPickupMain.txt"

#Component in
#Thickness = 197 to accomodate board stacking to clear runners
#-name COMPONENTIN -width 4440 -height 1660 -input "source\Pick Place for ComponentInBoardMod.txt" -thick 197 -quad BRD478XX.DIR -feeder "FeederPickupComponentIn.txt"

#RJ45 output
#-name RJ45TX -quad BRD16FXX.DIR -width 4760 -height 4902 -input "source\Pick Place for RJ45OutputV5.txt" -thick 197 -feeder "FeederPickupFrontPanelRJ45TX.txt" -x 4 -y -38
#Thickness = 197 to accomodate board stacking to clear runners
#RJ45TX-1
#-name RJ45TX-1 -width 4760 -height 4902 -input "source\Pick Place for RJ45OutputV5-1.txt" -thick 197 -quad BRD131XX.DIR -feeder "FeederPickupFrontPanelRJ45TX.txt" -y -10
#RJ45TX-2
#-name RJ45TX-2 -width 4760 -height 4902 -input "source\Pick Place for RJ45OutputV5-2.txt" -thick 197 -quad BRD138XX.DIR -feeder "FeederPickupFrontPanelRJ45TX.txt" -y -10

#RJ45 receiver Thickness = 197/163 to accomodate board stacking to clear runners +3x or +2x
#-width 3066 -height 2180 -input "source\Pick Place for RJ45ReceiverV4.txt" -side A -thick 197 -feeder "FeederPickupReceivers.txt"

#Board Name = RJ45RX_B
#-name RJ45RX_B -x 4 -y -5 -width 3066 -height 2180 -input "source\Pick Place for RJ45ReceiverV4.txt" -side B -thick 197 -quad BRD304XX.DIR -feeder "FeederPickupReceivers.txt"
# board thickness increased to account for board lifting necessary for close edge components
# X & Y offsets to align with vision run of initial alignment board

#Board Name = RJ45RX_T
#-x offset to accomodate jig offset
#-x -1438 -y 648 -name RJ45RX_T -width 3066 -height 2175 -input "source\Pick Place for RJ45ReceiverV4.txt" -side T -thick 197 -quad BRD342XX.DIR -feeder "FeederPickupReceivers.txt"

#Component out board
#Board name = "COMPONENT_OUT"
#-name COMPONENT_OUT -width 4470 -height 1925 -input "source\Pick Place for ComponentOutBoard.txt" -thick 63 -quad BRD528XX.DIR -feeder "FeederPickupReceivers.txt" -x 16 -y 22

#Front panel
#Board name = "FRONTPANEL"
#-name FRONTPANEL -width 5905 -height 1948 -thick 63 -input "source\Pick Place for Front Panel.txt" -quad BRD313XX.DIR -feeder "FeederPickupFrontPanelRJ45TX.txt"

#Local audio output 3x
#Board name = "LOCALAUDIO"
#-name LOCALAUDIO -width 4470 -height 5835 -thick 63 -input "source\Pick Place for Local Audio Out 3x.txt" -quad BRD37bxx.DIR -feeder "FeederPickupReceivers.txt" -x 5
##-width 4470 -height 5835 -thick 63 -input "source\Pick Place for Local Audio Out 3x-1.txt" -quad BRD35Dxx.DIR -feeder "FeederPickupReceivers.txt" -x 5 -y 8
##-width 4470 -height 5835 -thick 63 -input "source\Pick Place for Local Audio Out 3x-2.txt" -quad BRD35Cxx.DIR -feeder "FeederPickupReceivers.txt" -x 5 -y 8

sub DisplayHelp
{
    print "Command line arguments.\n";
    print " -width xxxx        : Board width in board units (Altium = mils, KiCad = mm)\n";
    print " -height xxxx       : Board height in board units (Altium = mils, KiCad = mm)\n";
    print " -thick xxxx        : Board thicknes in mils\n";
    print " -input abcd.pnp    : Input pick and place filename\n";
    print " -name BOARDNAME    : Board name\n";
    print " -quad BRDxxxxx.dir : Quad assigned board directory name\n";
    print " -side [T/B]        : Board side to process, default top\n";
    print " -vision [Y/N]      : Pause after initial sequence to allow vision position to be checked\n";
    print " -format xxxx       : Pick file format (altium or kicad, defalut altium)\n";
    print " -feeder abcd.txt   : Feeder location file\n";    
    print " -x xxxx            : Global placement x offset\n";    
    print " -y yyyy            : Global placement y offset\n";    
    print " -z yyyy            : Global placement z offset\n";    
    print " -putest [Y/N]      : Genertate test pickup of all components in feeder location file\n";
    print " -comptest [Y/N/M]  : Generate test pickup and place for each different component in PnP file. Front left most component positions used. 'M' uses BOARDNAME, 'Y' uses 'COMPONENTTEST, BRD60FXX.DIR'\n";
    print " -sort [F/P]        : Select report file list sort order. 'F' sorts by feeder, 'P' sorts by pickup count\n";
    print " -lifter [Y/N]      : Lift PCB after transport feed\n";
    print " -xscale xxxx       : Global placement x scale factor\n";    
    print " -yscale xxxx       : Global placement y scale factor\n";    
}

#Constants
use constant NOZZLE => 3;
use constant PICKUP => 1;
use constant PLACE => 2;
use constant TRANSPORT => 16;
use constant HOLD => 0;
use constant PASS => 1;

$NozzlePriority{"1"} = 1;
$NozzlePriority{"2"} = 2;
$NozzlePriority{"3"} = 3;
$NozzlePriority{"4"} = 4;
$NozzlePriority{"5"} = 5;
$NozzlePriority{"6"} = 6;
$NozzlePriority{"HAND"} = 7;
$NozzlePriority{"SKIP"} = 8;

#When lifters are used the lifting is not quite straight up
#Ultimately need to employ vision fudicials to correct for this
$LifterKickerY = -7;
$LifterKickerX = 0;
#Z-height of the top of the belt on the transport. Bigger number = lower
#$QuadReferenceZNoLifter = 1215;
$QuadReferenceZNoLifter = 1180;
#Z-height of the top of the lifters
$QuadReferenceZLifter = 970;

#Global adjustments to pickup locations to account for camera alignments
#NB NOT A GOOD IDEA SINCE POSITIONS NOW DIFFERENT TO PICKUP FILES!!!!
$PickupAdjustX = 0;
$PickupAdjustY = 0;
$PickupAdjustZ = 0;

$MaxSequenceCount = 500;
$MaxPlaceCount = 245;
$Segments = 0;
$TotalSequencesSent = 0;

#####################################
# Sub-routines                      #
#####################################

sub byfile {
  my @a = split /(\d+)/, $a;
  my @b = split /(\d+)/, $b;
  my $M = @a > @b ? @a : @b;
  my $res = 0;
  for (my $i = 0; $i < $M; $i++) {
    return -1 if ! defined $a[$i];
    return 1 if  ! defined $b[$i];
    if ($a[$i] =~ /\d/) {
      $res = $a[$i] <=> $b[$i];
    } else {
      $res = $a[$i] cmp $b[$i];
    }
    last if $res;
  }
  $res;
}
sub CropLength
{
  $Text = $_[0];
  $CropTo = $_[1];
  
  if (length($Text) > $CropTo)
  {
    return substr ($Text,0,$CropTo) 
  }
  else
  {
    return $Text;
  }
  
}

sub PadSpaces
{
  my $Text = $_[0];
  my $Target = $_[1];
  my $Current = length($Text);
  
  if ($Current < $Target)
  {
    $Result = $Text . substr("                                                                              ", 0, $Target - $Current);
  }
  else
  {
    $Result = $Text;
  }
  return CropLength($Result, $Target);
}

sub Append
{
  $PreList = $_[0];
  $Item = $_[1];
  $SplitAt = $_[2];
  
  #If the item to add is empty then make it a space so that splitting the list later retains the list order
  if ($Item eq "")
  {
    $Item = " ";
  }
  
  if ($SplitAt eq "")
  {
    $SplitAt = ",";
  }
  
  if ($PreList eq "")
  {
    return $Item;
  }
  else
  {
    return $PreList . $SplitAt . $Item;
  }
}

sub GetArg
{
  $Find = $_[0];  
  $Default = $_[1];
  $Index = 0;
  while($ARGV[$Index] ne "")
  {
    if ($ARGV[$Index] =~ /$Find/i)
    {
      return $ARGV[$Index + 1];
    }
    $Index += 2;
  }
  return $Default;
}

sub StripLeadingTrailingSpaces
{
  my $Text = $_[0];
  $Text =~ s/^\s+//; #remove leading spaces
  $Text =~ s/\s+$//; #remove trailing spaces
  return $Text;
}

sub StripAllSpaces
{
  my $Text = $_[0];
  $Text =~ s/\s//g; #remove spaces
  return $Text;
}

sub ReadChucks
{
    $Filename = "Chucks.txt";
    print "Reading chuck location table file.($Filename)\n";
    open(HANDLE, $Filename) || die "Could not open '$Filename'";
    $LineCount = 1;
    $ChuckCount = 0;
    while ($Data = <HANDLE>)
    {
        chop($Data);
        $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*).*/;
        if ($Data ne "")
        {
            if (not($Data =~/^#/))
            {
                $ChuckCount++;
                $X = $1;
                $Y = $2;
                $Z = $3;
                $Name = uc($4);
                $ChuckX{$ChuckCount} = $X;
                $ChuckY{$ChuckCount} = $Y;
                $ChuckZ{$ChuckCount} = $Z;
                $ChuckName{$ChuckCount} = $Name;
            }
        }
    }
}

#sub ReadAllFeederFiles
#{
#    ReadComponentFeeders("ComponentFeeders.txt");
#    ReadComponentFeeders($FeederFile);
#}

sub ReadComponentFeeders
{
    $Filename = $_[0];
    print "Reading component feeder table file ($Filename).\n";
    open(HANDLE, $Filename) || die "Could not open '$Filename'";
    $LineCount = 1;
    while ($Data = <HANDLE>)
    {
        chop($Data);
#        $Data = StripLeadingTrailingSpaces($Data);
#        $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*).*/;
#        $Data =~/(\S*)\t(\S*)\t(\S*)\t(\S*)\t(\S*)\t(\S*)\t(\S*)\t(\S*).*/;
        @Items = split(/\t/,$Data);
        if (StripLeadingTrailingSpaces($Data) ne "")
        {
            if (not($Data =~/^#/))
            {
                $ComponentFootprint = @Items[0];
                $ComponentComponent = @Items[1];
                $Comment = @Items[13];
                $Key = uc("$ComponentFootprint~$ComponentComponent");
                if ($ComponentFeeder{$Key} ne "")
                {
                    print "Error: Footprint/Component key not unique for $ComponentFootprint:$ComponentComponent at line $LineCount.\n";
                }
                else
                {
                    $ComponentLength{$Key} = @Items[2];
                    $ComponentWidth{$Key} = @Items[3];
                    $ComponentHeight{$Key} = @Items[4];
                    $ComponentCheckHeight{$Key} = @Items[5];
                    $Feeder = uc(@Items[6]);
                    $Nozzle = @Items[7];
                    $ComponentFeeder{$Key} = $Feeder;
                    if (($FeederToComponent{$Feeder} ne "") and ($Feeder ne "HAND") and ($Feeder ne "SKIP"))
                    {
                        print "Warning : Feeder '$Feeder' ($Key) already assigned to component $FeederToComponent{$Feeder} at line $LineCount.\n";
                    }
                    else
                    {
                        $FeederToComponent{uc(@Items[6])} = uc($Key);
                    }
                    #No component length was specified so do not use LAE
                    if ((($ComponentLength{$Key} == 0) or ($ComponentWidth{$Key} == 0)) and ($Feeder ne "HAND") and ($Feeder ne "SKIP"))
                    {
                      $MissingLAE{$Key} = $Feeder;
                      print "Warning : No LAE data for feeder $Feeder, component $Key\n";
                    }
                    $ComponentNozzle{$Key} = $Nozzle;
                    if (($Feeder ne "HAND") and ($Feeder ne "SKIP") and (($Nozzle < 1) or ($Nozzle > 6)))
                    {
                      print "Error : Invalid nozzle for feeder '$Feeder'\n";
                      $StopError = "Y";
                    }
                    $ComponentOrientation{$Key} = @Items[8];
                    $ComponentColumnStep{$Key} = @Items[9];
                    $ComponentRowStep{$Key} = @Items[10];
                    $ComponentXAdjust{$Key} = @Items[11];
                    $ComponentYAdjust{$Key} = @Items[12];
                    $ComponentComment{$Key} = $Comment;
                }
            }
        }
        $LineCount++;
    }
    close (HANDLE);
    if ($StopError eq "Y")
    {
      print "************************\n";
      print "Critical Error. Stopping\n";
      print "************************\n";
      exit(-1);
    }
}

sub ReadPnPDataKiCad
{
    $MaxX = -1000;
    $MinX = 1000;
    $MaxY = -1000;
    $MinY = 1000;
    print "Reading KiCad P&P file ($PnPFilename)\n";
    open(PNPHANDLE, $PnPFilename) || die "Could not open '$PnPFilename'";
    #Read header line
    while ($Data = <PNPHANDLE>)
    {
        chop($Data);
        if (($Data ne "") and not($Data =~/^#/))
        {
            $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)/;
            $Designator = uc($1);
            $Footprint = uc($3);
            $MidX = StripAllSpaces($4);
            $MidY = StripAllSpaces($5);
            
            $MidX = $MidX * $Scale;
            $MidY = $MidY * $Scale;

            if ($MidX < $MinX)
            {
              $MinX = $MidX;
            }
            if ($MidX > $MaxX)
            {
              $MaxX = $MidX;
            }
            
            if ($MidY < $MinY)
            {
              $MinY = $MidY;
            }
            if ($MidY > $MaxY)
            {
              $MaxY = $MidY;
            }

            $TopBottom = uc($7);
            if ($TopBottom eq "TOP")
            {
              $TopBottom = "T";
            }
            elsif ($TopBottom eq "BOTTOM")
            {
              $TopBottom = "B";
            }
            $Rotation = StripAllSpaces($6);
            $Comment = StripAllSpaces($2);
            
            if ($Comment eq "")
            {
                print "Component value field blank at line $LineCount for component $Designator\n";
            }
            $Key = uc("$Footprint~$Comment");
            $Nozzle = $ComponentNozzle{$Key};
            if ($Nozzle eq "")
            {
                $Nozzle = "HAND";
            }
            #Rebuild a data string in Altium format for parsing later
            $NewData = "$Designator $Footprint $MidX $MidY RefX RefY PadX PadY $TopBottom $Rotation $Comment";
            $Priority = $NozzlePriority{$Nozzle};
            #Can make component placement order sorting anything, i.e. all same components first, place in x, place in y etc... by changing first field
            #Second field MUST be component data
            $Temp = "$Priority:$NewData"; 
            push(@PnPData, $Temp);
        }
    }
    print "X range = $MinX - $MaxX\n";
    print "Y range = $MinY - $MaxY\n";
    @SortedPnPData = sort(@PnPData);
    $PnPEntries = @SortedPnPData;
    CreatePnPStructures();
}

sub ReadPnPDataAltium
{
    print "Reading Altium P&P file ($PnPFilename)\n";
    open(PNPHANDLE, $PnPFilename) || die "Could not open '$PnPFilename'";
    #Read header line
    $Data = <PNPHANDLE>;
    while ($Data = <PNPHANDLE>)
    {
        chop($Data);
        if ($Data ne "")
        {
            $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)/;
            $Designator = uc($1);
            $Footprint = uc($2);
            $MidX = StripAllSpaces($3) * $Scale;
            $MidY = StripAllSpaces($4) * $Scale;
            $TopBottom = uc($9);
            $Rotation = StripAllSpaces($10);
            $Comment = StripAllSpaces($11);
            if ($Comment eq "")
            {
                print "Component value field blank at line $LineCount for component $Designator\n";
            }
            $Key = uc("$Footprint~$Comment");
            $Nozzle = $ComponentNozzle{$Key};
            if ($Nozzle eq "")
            {
                $Nozzle = "HAND";
            }
            $Priority = $NozzlePriority{$Nozzle};
            #Can make component placement order sorting anything, i.e. all same components first, place in x, place in y etc... by changing first field
            #Second field MUST be component data
            $Temp = "$Priority:$Data"; 
            push(@PnPData, $Temp);
        }
    }
    @SortedPnPData = sort(@PnPData);
    $PnPEntries = @SortedPnPData;
#    for ($Count = 0; $Count < $PnPEntries; $Count++)
#    {
#        print "@SortedPnPData[$Count]\n";
#    }
    CreatePnPStructures();
}

sub ReducePnPData()
{
  for ($PnPIndex = 0; $PnPIndex < $PnPEntries; $PnPIndex++)
  {
    $Current = @SortedPnPData[$PnPIndex];
    $Current =~ /(.*):(.*)/;
    $Data = $2;
    chomp($Data);
    if ($Data ne "")
    {
      $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)/;
      $Designator = uc($1);
      $Footprint = uc($2);
      $MidX = $3;
      $MidY = $4;
      $TopBottom = uc($9);
      $Rotation = $10;
      if ($TopBottom eq "B") 
      {
          $MidX = $BoardWidth - $MidX;
      }
      $Comment = uc($11);
      $CommentRaw = $Comment;
      $Comment =~ /(\S*)\s*(.*)/;
      $Comment = StripAllSpaces($Comment);
      $Key = uc("$Footprint~$Comment");
      if ($NewY{$Key} == 0)#If not defined yet then set Y to something big
      {
        $NewY{$Key} = 1000000;
      }
      if (($MidX >= $NewX{$Key}) and ($MidY <= $NewY{$Key})) #This instance of the component placement is closer to the index point
      {
        $NewPnPData{$Key} = $Current;
        $NewX{$Key} = $MidX;
        $NewY{$Key} = $MidY;
      }
    }
  }
  $Count = 0;
  foreach $Key (keys %NewPnPData)
  {
    $NewPnPDataArray[$Count] = $NewPnPData{$Key};
    $Count++;
  }
  
  @SortedPnPData = sort(@NewPnPDataArray);
  $PnPEntries = @SortedPnPData;
  
  print "*********************************************\n";
  print "* Only generating test component  sequences *\n";
  print "*********************************************\n";
}

sub CreatePnPStructures
{
    $LineCount = 1;
    $TotalPlaceCount = 0;
    $TotalComponentCount = 0;
#    #Read header line
#    $Data = <PNPHANDLE>;
    if (($ComponentTest eq "Y") or ($ComponentTest eq "M"))#If component test = yes or merge then reduce the list to one of each component
    {
      ReducePnPData();
    }
    for ($PnPIndex = 0; $PnPIndex < $PnPEntries; $PnPIndex++)
    {
        $Current = @SortedPnPData[$PnPIndex];
        $Current =~ /(.*):(.*)/;
        $SortedByTerm = $1;#Not used
        $Data = $2;
        chomp($Data);
        if ($Data ne "")
        {
            $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)/;
            $Designator = uc($1);
            $Footprint = uc($2);
            $MidX = $3 * $XScale;
            $MidY = $4 * $YScale;
            $TopBottom = uc($9);
            $Rotation = $10;
            if ($TopBottom eq "B") 
            {
                $MidX = $BoardWidth - $MidX;
            }
            $Component = uc($11);
            $ComponentRaw = $Component;
            $Component =~ /(\S*)\s*(.*)/;
            $Component = StripAllSpaces($Component);
            $Key = uc("$Footprint~$Component");
            if (($1 ne "DNP") and ((uc($DoTopBottom) eq "A") or (uc($DoTopBottom) eq $TopBottom)))
            {
                $TotalComponentCount++;
                if ($ComponentFeeder{$Key} eq "")
                {
                    $UnPickable{$Key} ++;
                    $UnPickableDesignators{$Key} = Append($UnPickableDesignators{$Key}, $Designator);
                }
                elsif (uc$ComponentFeeder{$Key} eq "HAND")
                {
                    $HandPlaceCount++;
                    $PlaceCount{$Key}++;

                    $HandPickable{$Key} ++;
                    $HandPickableDesignators{$Key} = Append($HandPickableDesignators{$Key}, $Designator);
                }
                elsif (uc$ComponentFeeder{$Key} eq "SKIP")
                {
                    $SkipPlaceCount++;
                    $PlaceCount{$Key}++;

                    $SkipPickable{$Key} ++;
                    $SkipPickableDesignators{$Key} = Append($SkipPickableDesignators{$Key}, $Designator);
                }
                else
                {
                    if ($PlaceCount{$Key} eq "")
                    {
                        $UniqueComponents++;
                        $IndexToKey{$UniqueComponents} = $Key;
                        $KeyToIndex{$Key} = $UniqueComponents;
                        $CompFootprint{$UniqueComponents} = $Footprint;
                        $CompComponent{$UniqueComponents} = $Component;
                        $UsedPickup{$ComponentFeeder{$Key}} = $Key;
                    }
                    $PlaceCount{$Key}++;
                    #Origin within Altium must be set to bottom right
                    #Coordinates are -ve, so invert to match Quad directions
                    $TotalPlaceCount++;
                    $MachineLocalX{$Designator} = $MidX;
                    $MachineLocalY{$Designator} = $BoardHeight - $MidY;
                    $PlaceMachineAbsoluteX{$TotalPlaceCount} = $QuadReferenceX - $BoardWidth + $MachineLocalX{$Designator};
                    $PlaceMachineAbsoluteY{$TotalPlaceCount} = $QuadReferenceY + $MachineLocalY{$Designator};
                    if ($TopBottom eq "T")
                    {
                        $PlaceComponentRotation{$TotalPlaceCount} = 360 - $Rotation; #Protel rotation correction
                    }
                    else
                    {
                        $PlaceComponentRotation{$TotalPlaceCount} = $Rotation + 180; #Protel rotation correction
                    }
                    
                    $PlaceCompopnentDesignator{$TotalPlaceCount} = $Designator;
                    $PlaceComponentFootprint{$TotalPlaceCount} = $Footprint;
                    $PlaceComponentComponent{$TotalPlaceCount} = $Component;
                    $Placeable = Append($Placeable, $Designator);
                    $Nozzle = $ComponentNozzle{$Key};
                    $NozzleUsed{$Nozzle}++;
                }
            }
        }
        $LineCount++;
    }
}

sub CheckArguments
{
    $Stop = 0;
    if ($BoardWidth eq "")
    {
        print "No board width specified.\n";
        $Stop = 1;
    }
    if ($BoardHeight eq "")
    {
        print "No board height specified.\n";
        $Stop = 1;
    }
    if ($BoardThickness eq "")
    {
        print "No board thickness specified.\n";
        $Stop = 1;
    }
    if ($PnPFilename eq "")
    {
        $PnPFilename = "PnP.txt";
    }
    if ($DoTopBottom eq "")
    {
        $DoTopBottom = "T";
    }
    
    return $Stop;
}

sub ReadFeederPickup
{
    $Filename = $_[0];
    print "Reading feeder pickup location file ($Filename).\n";
    open(HANDLE, $Filename) || die "Could not open '$Filename'";
    $LineCount = 1;
    $FeederPickupCount = 0;
    while ($Data = <HANDLE>)
    {
        chop($Data);
        $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(.*)/;
        if ($Data ne "")
        {
            if (not($Data =~/^#/))
            {
                $FeederID = uc($1);
                if ($FeederLocationToIndex{$FeederID} ne "")
                {
                    print "Error : Line $LineCount. Feeder pickup information for $FeederID already defined.\n"
                }
                else
                {
                    $FeederPickupCount++;
                    $FeederLocationToIndex{$FeederID} = $FeederPickupCount;
                    $FeederIndexToLocation{$FeederPickupCount} = $FeederID;
                    $FeederX{$FeederID} = $2 + $PickupAdjustX;
                    $FeederY{$FeederID} = $3 + $PickupAdjustY;
                    $FeederZ{$FeederID} = $4 + $PickupAdjustZ;
                    $FeederT{$FeederID} = $5;
                    $FeederRows{$FeederID} = uc($6);
                    $FeederColumns{$FeederID} = uc($7);
                    $FeederLocationName{$FeederID} = uc($8);
                    $UsedOn{$FeederID} = uc($9);
                }
            }
        }
        $LineCount++;
    }
    close (HANDLE);
}

sub SendBinaryWord
{
    $Data = $_[0];
    $U = int ($Data / 256);
    $L = ($Data % 256);
    printf (OUTPUTHANDLE "%c%c", $L, $U);
    if (($U < 0) or ($L < 0))
    {
        #die "FATAL ERROR : -ve byte in SendBinaryWord. Need to fix script for this condition!!!\n";
        print "FATAL ERROR : -ve byte in SendBinaryWord. Need to fix script for this condition!!!\n";
    }
}

sub SendHeader
{
    $FileSize = 16 + (10 * $ExtentCount) + (10 * $UniqueComponents) + (10 * $FilePlaceCount) + (10 * $ChuckCount) + (4 * $FileSequenceCount);
    if ($FileSize > 22527)
    {
        print "ERROR : FILE SIZE WOULD BE TOO LARGE!!!\n";
        exit -1;
    }
    $FSU = int ($FileSize / 256);
    $FSL = ($FileSize % 256);
    $SQU = int ($FileSequenceCount / 256);
    $SQL = ($FileSequenceCount % 256);
    printf (OUTPUTHANDLE "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", $SQL, $UniqueComponents, $FilePlaceCount, $ChuckCount, 0, 0, $ExtentCount, $FSL, $FSU + 168, 0, 0, 0, 0, 0, 0, $SQU);
}

sub SendSequenceData
{
    for ($Index = 0; $Index < $FileSequenceCount; $Index++)
    {
        printf(OUTPUTHANDLE "%c%c%c%c", $SequenceCommand{$TotalSequencesSent}, $SequenceParameter{$TotalSequencesSent}, 255, 255);
        $TotalSequencesSent++;
    }
}

sub SendChuckData
{
    open(CHUCKHANDLE, ">CHUCK1.REF") || die "Could not open 'CHUCK1.REF'";
    for ($Index = 1; $Index <= $ChuckCount; $Index++)
    {
        printf(CHUCKHANDLE "%03d %s\n", $Index, $ChuckName{$Index});
        printf(OUTPUTHANDLE "%c%c", 0,0);
        SendBinaryWord($ChuckX{$Index});
        SendBinaryWord($ChuckY{$Index});
        SendBinaryWord(0);
        SendBinaryWord($ChuckZ{$Index});
    }
    close CHUCKHANDLE;
}

sub SendPickupData
{
    for ($Index = 1; $Index <= $UniqueComponents; $Index++)
    {
        $Key = $IndexToKey{$Index};
        #Get the component height
        $Height = $ComponentHeight{$Key};
        $XAdj = $ComponentXAdjust{$Key};
        $YAdj = $ComponentYAdjust{$Key};
        #Get the base coordinates
        $LogicalFeeder = $ComponentFeeder{$Key};
        if (($LogicalFeeder ne "HAND") and ($LogicalFeeder ne "SKIP"))
        {
            $X = $FeederX{$LogicalFeeder};
            $Y = $FeederY{$LogicalFeeder};
            $Z = $FeederZ{$LogicalFeeder};
            if (($X eq "") and ($CurrentSegment == 1))
            {
                print "Error : No feeder location information for $LogicalFeeder.\n";
                $MissingFeederData{$LogicalFeeder} = "Y";
            }
            #Calculate the corrected settings
            $NewX = $X + $XAdj;
            $NewY = $Y + $YAdj;
            $NewZ = $Z; #Pickup height taken directly from feederpickup.txt for the moment since easier to actually find this on the machine.
            $NewT = 0; #Pickup orientation always 0 since length and width should be read from 0 referenced LAE reading
            $Alternate = 0;
            if ($ComponentPURepeatExtent{$Key} ne "")
            {
                $Extent = $ComponentPURepeatExtent{$Key};
            }
            elsif ($ComponentLEAExtent{$Key} ne "")
            {
                $Extent = $ComponentLEAExtent{$Key};
            }
            else
            {
                #No component length was specified so do not use LAE
                $Extent = 0;
            }
            
            
            printf (OUTPUTHANDLE "%c%c", $Alternate, $Extent);
            SendBinaryWord($NewX);
            SendBinaryWord($NewY);
            SendBinaryWord($NewT);
            SendBinaryWord($NewZ);
        }
    }
}

sub SendPlaceData
{
#    if ($Segments == 1) #STEVE FIX FOR MULTI_SEGMENT
    if ($Segments == 0)
    {
        $Start = 0;
    }
    else
    {
        $Start = ($CurrentSegment - 1) * $MaxPlaceCount;
    }

    for ($Count = 1; $Count <= $FilePlaceCount; $Count++)
    {
        $Index = $Count + $Start;
        $Footprint = $PlaceComponentFootprint{$Index};
        $Comment = $PlaceComponentComponent{$Index};
        $Key = $Footprint . "~" . $Comment;
        $Reference = $Index;
        $FeederID = $ComponentFeeder{$Key};
        $Designator = $PlaceCompopnentDesignator{$Index};
        $PlaceX = $PlaceMachineAbsoluteX{$Index} + $XAdjust;
        $PlaceY = $PlaceMachineAbsoluteY{$Index} + $YAdjust;
        $PlaceT = ($PlaceComponentRotation{$Index} + 90 + $FeederT{$FeederID} + $ComponentOrientation{$Key}) / 0.015;
        $PlaceT = ($PlaceT % 24000);
        $PlaceZ = $QuadReferenceZ - $BoardThickness - $ComponentHeight{$Key} + $ZAdjust;
        $Alternate = 0;
        $Extent = 0;
        printf (OUTPUTHANDLE "%c%c", $Alternate, $Extent);
        SendBinaryWord($PlaceX);
        SendBinaryWord($PlaceY);
        SendBinaryWord($PlaceT);
        SendBinaryWord($PlaceZ);
        $PlaceXInt = int($PlaceX);
        $PlaceYInt = int($PlaceY);
        printf(CHECKHANDLE "$Designator\t$PlaceXInt\t$PlaceYInt\t$PlaceT\t$PlaceZ\n");
    }
}

sub AddExtent
{
    $ExtentCount++;
    $ExtentD1{$ExtentCount} = $_[0];
    $ExtentD2{$ExtentCount} = $_[1];
    $ExtentD3{$ExtentCount} = $_[2];
    $ExtentD4{$ExtentCount} = $_[3];
    $ExtentD5{$ExtentCount} = $_[4];
    $ExtentD6{$ExtentCount} = $_[5];
    $ExtentD7{$ExtentCount} = $_[6];
    $ExtentD8{$ExtentCount} = $_[7];
    $ExtentD9{$ExtentCount} = $_[8];
    $ExtentD10{$ExtentCount} = $_[9];
    return $ExtentCount;
}

sub SendExtentData
{
    for ($Index = 1; $Index <= $ExtentCount; $Index++)
    {
        $D1 = $ExtentD1{$Index};
        $D2 = $ExtentD2{$Index};
        $D3 = $ExtentD3{$Index};
        $D4 = $ExtentD4{$Index};
        $D5 = $ExtentD5{$Index};
        $D6 = $ExtentD6{$Index};
        $D7 = $ExtentD7{$Index};
        $D8 = $ExtentD8{$Index};
        $D9 = $ExtentD9{$Index};
        $D10 = $ExtentD10{$Index};
        printf (OUTPUTHANDLE "%c%c%c%c%c%c%c%c%c%c", $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $D10);
    }
}

sub AddBoardExtents
{
    #Send board information data
    $BWU = int ($BoardWidth / 256);
    $BWL = ($BoardWidth % 256);
    $PIN = 0;
    $BSTRT = 224;
    $BMAX = 117;
    $BA = 456;
    $BAU = int ($BA / 256);
    $BAL = ($BA % 256);
    $GAP = 80;
    $DIS2PIN = 54;
    $RSTRT = 224;
    $RMAX = 90;
    $RAC = 456;
    $RACU = int ($RAC / 256);
    $RACL = ($RAC % 256);
    
    $Count = $ExtentCount + 2;
    
#    $BoardSizeExtent = AddExtent(0x06, $Count, $BWL, $BWU, $PIN, $BSTRT, $BMAX, $BAL, $BAU, 0x00);
#    AddExtent(0x07, 0x00, $GAP, $DIS2PIN, $RSTRT, $RMAX, $RACL, $RACU, 0x00, 0x00);
}

sub AddLAEExtents
{
    for ($Index = 1; $Index <= $UniqueComponents; $Index++)
    {
        $Key = $IndexToKey{$Index};
        $Length = $ComponentLength{$Key};
        $Width = $ComponentWidth{$Key};
        $ZMeasure = $ComponentCheckHeight{$Key};
        #0 = none
        #1 = slow leaded
        #2 = medium leaded
        #3 = fast leaded
        #4 = slow non-leaded
        #5 = medium non-leaded
        #6 = fast non-leaded
        #7 = slow very small
        #8 = medium very small
        #9 = fast very small
        if ($ZMeasure >= 0)
        {
          $MeasureType = 4;
        }
        else
        {
          $MeasureType = 1;
          $ZMeasure = -$ZMeasure;
        }
        $WU = int ($Width / 256);
        $WL = ($Width % 256);
        $LU = int ($Length / 256);
        $LL = ($Length % 256);
        $ZU = int ($ZMeasure / 256);
        $ZL = ($ZMeasure % 256);
        $PUD = 20;
        $LTOL = 25;
        $WTOL = 25;
        if (($Length !=0) and ($Width != 0))
        {
          $ComponentLEAExtent{$Key} = AddExtent(0x0c, 0x00, $WL, $WU + ($WTOL * 8), $LL, $LU + ($LTOL * 8), $ZL, $ZU + ($MeasureType * 4), $PUD, 0);
        }
    }
}

sub AddRepeatPickupExtents
{
    for ($Index = 1; $Index <= $UniqueComponents; $Index++)
    {
        $Key = $IndexToKey{$Index};
        $LogicalFeeder = $ComponentFeeder{$Key};
        $LAE = $ComponentLEAExtent{$Key};
        #If not size data then do not add LAE data
        if ($ComponentLength{$Key} == 0)
        {
            $LAE = 0;
        }
        $ColumnStep = $ComponentColumnStep{$Key};
        $RowStep = $ComponentRowStep{$Key};
        $B1 = int ($ColumnStep / 256);
        $B2 = $L = ($ColumnStep % 256);
        $B3 = int ($RowStep / 256);
        $B4 = $L = ($RowStep % 256);
        $Columns = $FeederColumns{$LogicalFeeder};
        $Rows = $FeederRows{$LogicalFeeder};
        if (($ColumnStep != 0) or ($RowStep != 0))
        {
            $ComponentPURepeatExtent{$Key} = AddExtent(0x01, $LAE, $B1, $B2, $B3, $B4, $Columns, $Rows, 0xff, 0xff);
        }
    }
}

sub BuildExtentList
{
    AddLAEExtents;
    AddRepeatPickupExtents;
    
    AddBoardExtents;
}

sub GenerateBRDATA1
{

    BuildExtentList();
   
    $PlaceItemsLeft = $TotalPlaceCount;
    
    $CurrentSegment = 0;
    
    open(CHECKHANDLE, ">Place.txt")|| die "Could not open 'Place.txt'";
    printf(CHECKHANDLE "Des.\tPlaceX\tPlaceY\tPlaceT\tPlaceZ\n");
    
    while($PlaceItemsLeft > 0)
    {
        $CurrentSegment++;
        $FileSegmentExt = sprintf("%03d", $CurrentSegment);
#        if ($Segments == 1)
        if ($Segments == 0)#STEVE FIX FOR MULTI_SEGMENT
        {
            $Filename = "BRDATA1.DAT";
        }
        else
        {
            $CurrentFileSegment = $CurrentSegment;
            $Filename = "BRDATA1.$FileSegmentExt";
        }
        open(OUTPUTHANDLE, ">$Filename")|| die "Could not open '$Filename'";
        binmode OUTPUTHANDLE;
        
        $FileSequenceCount = $SegmentCount{$CurrentSegment};
        if ($PlaceItemsLeft > $MaxPlaceCount)
        {
            $FilePlaceCount = $MaxPlaceCount;
            $PlaceItemsLeft = $PlaceItemsLeft - $MaxPlaceCount;
        }
        else
        {
            $FilePlaceCount = $PlaceItemsLeft;
            $PlaceItemsLeft = 0;
        }
        SendHeader();
        SendSequenceData();
        SendPickupData();
        SendPlaceData();
        SendChuckData();
        SendExtentData();
        close(OUTPUTHANDLE);
        GeneratePlaceRef();
        GeneratePickRef();
    }
    close(CHECKHANDLE);
}

sub GeneratePlaceRef
{
#    if ($Segments == 1)
    if ($Segments == 0)#STEVE FIX FOR MULTI_SEGMENT
    {
        $Filename2 = "PLACE1.REF";
        $Start = 0;
    }
    else
    {
        $Filename2 = "PLC1$FileSegmentExt.REF";
        $Start = ($CurrentSegment - 1) * $MaxPlaceCount;
    }
    open(OUTPUTHANDLE2, ">$Filename2")|| die "Could not open '$Filename2'";
    for ($Count = 1; $Count <= $FilePlaceCount; $Count++)
    {
        $Index = $Count + $Start;
        $Footprint = $PlaceComponentFootprint{$Index};
        $Component = $PlaceComponentComponent{$Index};
        $Key = $Footprint . "~" . $Component;
        $Reference = $Count;
        $FeederID = $ComponentFeeder{$Key};
        $Designator = $PlaceCompopnentDesignator{$Index};
        $PlaceX = $PlaceMachineAbsoluteX{$Index} + $XAdjust;
        $PlaceY = $PlaceMachineAbsoluteY{$Index} + $YAdjust;
        $PlaceT = ($PlaceComponentRotation{$Index} + 90 + $FeederT{$FeederID} + $ComponentOrientation{$Key}) / 0.015;
        $PlaceT = ($PlaceT % 24000);
        $PlaceZ = $QuadReferenceZ - $BoardThickness - $ComponentHeight{$Key} + $ZAdjust;
        $Key =~ /.*~(.*)/;
        $Value = $1;
        $NewComponent = $Value . "_" . $Footprint;
        $NewComponent = CropLength($NewComponent, 24);
        $Designator10 = CropLength($Designator, 10);
#        if ($Segments == 1)
#        {
            printf (OUTPUTHANDLE2 "%03d %-24s %-10s\n", $Count, $NewComponent, $Designator10);
#        }
#        else
#        {
#            printf (OUTPUTHANDLE2 "%-11s%04d  0  0  0.0000  0.0000  0.0000  0.0000%-25s%03d  0  0 0.000  0\n", $Designator, $Index + 1000, $NewComment,$Index);
#        }
    }
    close(OUTPUTHANDLE2);
}

sub GeneratePickRef
{
#    if ($Segments == 1)
    if ($Segments == 0)#STEVE FIX FOR MULTI_SEGMENT
    {
        $Filename = "PICK1.REF";
    }
    else
    {
        $Filename = "PICK1$FileSegmentExt.REF";
    }
    open(OUTPUTHANDLE, ">$Filename") || die "Could not open '$Filename'";
    for ($Index = 1; $Index <= $UniqueComponents; $Index++)
    {
        $Key = $IndexToKey{$Index};
        $LogicalFeeder = $ComponentFeeder{$Key};
        $FootprintComment = $FeederToComponent{$LogicalFeeder};
        $FootprintComment =~ /(.*)~(.*)/;
        $DesignatorFootprint = $2 . "_" . "$1";
        
        $DesignatorFootprint = CropLength($DesignatorFootprint, 24);
        printf (OUTPUTHANDLE "%03d %-24s\n", $Index, $DesignatorFootprint);
    }
    close(OUTPUTHANDLE);
}

sub AddSequence
{
    $Command = $_[0];
    $Parameter = $_[1];
    
    if (($Command == PICKUP) and ($Parameter == 0))
    {
        $Steve++;
    }
    $SequenceCommand{$TotalSequenceCount} = $Command;
    $SequenceParameter{$TotalSequenceCount} = $Parameter;
    $CurrentSequenceCount++;
    $TotalSequenceCount++;
}

sub BuildSequenceList
{
    $TotalSequenceCount = 0;
    $TotalNozzleCount = keys %NozzleUsed;
    $CurrentSequenceCount = 0;
    $CurrentPlaceCount = 0;
    $UsingNozzle = "";
    
    if ($Vision eq "Y")
    {
      #Add stop after initial run to pause after vision align
      AddSequence(HOLD, 0);
    }
    for ($Index = 1; $Index <= $TotalPlaceCount; $Index++)
    {
        $CurrentPlaceCount ++;
        $Component = $PlaceComponentComponent{$Index};
        $Footprint = $PlaceComponentFootprint{$Index};
        $Key = $Footprint . "~" . $Component;
        $CurrentNozzle = $ComponentNozzle{$Key};
        if ($UsingNozzle ne $CurrentNozzle)
        {
            AddSequence(NOZZLE, $CurrentNozzle);
            $UsingNozzle = $CurrentNozzle;
        }
        $Designator = $PlaceCompopnentDesignator{$Index};
        $PhysicalIndex = $KeyToIndex{$Key};
        AddSequence(PICKUP, $PhysicalIndex);
        $Place = $CurrentPlaceCount;
        $ReorganizedPlace{$Index} = $CurrentPlaceCount;
        AddSequence(PLACE, $Place);
        if ($CurrentPlaceCount == $MaxPlaceCount)
        {
            $Segments++;
            $SegmentCount{$Segments} = $CurrentSequenceCount;
            $CurrentPlaceCount = 0;
            $CurrentSequenceCount = 0;
            AddSequence(NOZZLE, $CurrentNozzle);
        }
    }
    AddSequence(HOLD, 0);
    $SegmentCount{$Segments + 1} = $CurrentSequenceCount;
}

sub CreateBoardNameFile
{
    $Filename = "BRDNAME.DAT";
    open(OUTPUTHANDLE, ">$Filename") || die "Could not open '$Filename'";
#    printf (OUTPUTHANDLE "%s%c",$BoardName, 0);
    printf (OUTPUTHANDLE "%s",$BoardName);
    if ($DoVision eq "Y")
    {
        printf (OUTPUTHANDLE "\n");
        printf (OUTPUTHANDLE "00000\n");
        printf (OUTPUTHANDLE "N\n");
        printf (OUTPUTHANDLE "YNNNNN\n");
        printf (OUTPUTHANDLE "NNNNNN\n");
        printf (OUTPUTHANDLE "N\n");
        printf (OUTPUTHANDLE "5\n");
        printf (OUTPUTHANDLE "N\n");
        printf (OUTPUTHANDLE "5\n");
        printf (OUTPUTHANDLE "N\n");
        printf (OUTPUTHANDLE "222222\n");
        printf (OUTPUTHANDLE "222222\n");
        printf (OUTPUTHANDLE "NNNNNN\n");
        printf (OUTPUTHANDLE "NNNNNN\n");
        printf (OUTPUTHANDLE "NNNNNN\n");
        printf (OUTPUTHANDLE "NNNNNN\n");   
    }
    close OUTPUTHANDLE;
}

sub GenerateReport
{
    open(REPORTHANDLE, ">Report.txt") || die "Could not open 'Report.txt'";
    $TEP = $BoardWidth + 25;
    printf REPORTHANDLE "Input filename = '$PnPFilename'\n";
    printf REPORTHANDLE "Output directory = '$QuadDir'\n";
    printf REPORTHANDLE "Board name = '$BoardName'\n";    
    printf REPORTHANDLE "Board size = $BoardWidth x $BoardHeight x $BoardThickness. Set TEP to $TEP\n";
    printf REPORTHANDLE "Processing side $DoTopBottom\n\n";
    printf REPORTHANDLE "$UniqueComponents unique pickable components.\n";
    
    printf REPORTHANDLE "   PU  Footptint            Component                 Count Feeder   Comment        Nzl\n";
    $Total = 0;
    for ($Index = 1; $Index <= $UniqueComponents; $Index++)
    {
      $Footprint = PadSpaces($CompFootprint{$Index}, 20);
      $Component = PadSpaces($CompComponent{$Index}, 25);
      $Key = $IndexToKey{$Index};
      $Count = PadSpaces($PlaceCount{$Key}, 5);
      $Total = $Total + $Count;
      $Feeder = PadSpaces($ComponentFeeder{$Key}, 8);
      $Nozzle = $ComponentNozzle{$Key};
      $Pickup = PadSpaces($Index, 3);
     
      
      $Comment = PadSpaces($ComponentComment{$Key}, 14);
      $Item = "$Pickup $Footprint $Component $Count $Feeder $Comment $Nozzle\n";
        
#        $Location = "(" . $FeederLocationName{$ComponentFeeder{$Key}} . ")";
#        $Location =~ s/LOCATION = //g;
#        $Location = PadSpaces($Location, 12);
#        if ($Location ne "()          ")
#        {
#            $Item = "$Footprint $Component $Count $Feeder$Location $Nozzle\n";
#        }
#        else
#        {
#            $Item = "$Footprint $Component $Count $Feeder             $Nozzle\n";
#        }

      if ($ReportSortMode eq "F")
      {
        $SortKey = $Feeder;
      }
      else #if ($ReportSortMode eq "P")
      {
        $SortKey = sprintf("%03d", $Index);
      }
      #$ListInfo{$Feeder} = Append($ListInfo{$Feeder}, $Item, "^");
      if ($ListInfo{$SortKey} ne "")#Kludge to make list appear correct due to replaced components
      {
          $ListInfo{$SortKey."."} = Append($ListInfo{$SortKey."."}, $Item, "^");
      }
      else
      {
          $ListInfo{$SortKey} = Append($ListInfo{$SortKey}, $Item, "^");
      }
    }
    $Count = 1;
    
    foreach $KeyToPrint (sort byfile (keys %ListInfo))
    {
      $PrintText = PadSpaces($Count,3) . $ListInfo{$KeyToPrint};
      $PrintText =~ s/\^/   /g;
      printf REPORTHANDLE $PrintText;
      $Count ++;
    }
    printf REPORTHANDLE "Total                                             $Total\n";

    $HandplaceableCount = keys (%HandPickable); 

    printf REPORTHANDLE "\n$HandplaceableCount Hand placed components.\n";
    
    $LineCount = 1;
    $Total = 0;
    foreach $Key (keys %HandPickable)
    {
      $TimesUsed = PadSpaces($HandPickable{$Key}, 3);
      $Total = $Total + $TimesUsed;
      $Index = PadSpaces($LineCount, 6);
      $Key =~/(.*)~(.*)/;
      $Footprint = PadSpaces($1, 20);
      $Component = PadSpaces($2, 25);
      print REPORTHANDLE "$Index $Footprint $Component $TimesUsed $HandPickableDesignators{$Key}\n";
      $LineCount++;
    }
    printf REPORTHANDLE "Total                                                 $Total\n";
    print REPORTHANDLE "\n";

    $SkipplaceableCount = keys (%SkipPickable); 

    if ($SkipplaceableCount > 0)
    {
      printf REPORTHANDLE "$SkipplaceableCount Skipped components.\n";
      $LineCount = 1;
      $Total = 0;
      foreach $Key (keys %SkipPickable)
      {
          $TimesUsed = PadSpaces($SkipPickable{$Key}, 3);
          $Total = $Total + $TimesUsed;
          $Index = PadSpaces($LineCount, 6);
          $Key =~/(.*)~(.*)/;
          $Footprint = PadSpaces($1, 20);
          $Component = PadSpaces($2, 25);
          print REPORTHANDLE "$Index $Footprint $Component $TimesUsed $SkipPickableDesignators{$Key}\n";
          $LineCount++;
      }
      printf REPORTHANDLE "Total                                                 $Total\n";
      print REPORTHANDLE "\n";
    }
  
    $UnplaceableCount = keys (%UnPickable);
    if ($UnplaceableCount > 0)
    {
      printf REPORTHANDLE "$UnplaceableCount un-pickable components.\n";
      
      $LineCount = 1;
      $Total = 0;
      foreach $Key (keys %UnPickable)
      {
          $TimesUsed = PadSpaces($UnPickable{$Key}, 3);
          $Total = $Total + $TimesUsed;
          $Index = PadSpaces($LineCount, 6);
          $Key =~/(.*)~(.*)/;
          $Footprint = PadSpaces($1, 20);
          $Component = PadSpaces($2, 25);
          $UPDes = $UnPickableDesignators{$Key};
          print REPORTHANDLE "$Index $Footprint $Component $TimesUsed ($UPDes)\n";
          $LineCount++;
      }
      printf REPORTHANDLE "Total                                                 $Total\n";
      print REPORTHANDLE "\n";
    }
    
    $LAEMissingCount = keys(%MissingLAE);
    if ($LAEMissingCount > 0)
    {
      print REPORTHANDLE "\nComponents missing LAE data\n";
      foreach $Key(keys %MissingLAE)
      {
        $ComponentData = PadSpaces($Key, 40);
        $PickupLocation = PadSpaces($MissingLAE{$Key}, 10);
        $PickupStep = PadSpaces($KeyToIndex{$Key}, 4);
        print REPORTHANDLE "$PickupLocation pickup step $PickupStep $ComponentData\n";
      }
      print REPORTHANDLE "\n";
    }

    $MissingFeederCount = keys(%MissingFeederData);
    if ($MissingFeederCount > 0)
    {
      print REPORTHANDLE "\nMissing feeder locations\n";
      print "Missing feeder locations\n";
      foreach $Feeder (sort keys %MissingFeederData)
      {
        $ComponentData = $FeederToComponent{$Feeder};
        $ComponentData =~ /(.*)~(.*)/;
        $Footprint = PadSpaces($1, 20);
        $Component = PadSpaces($2, 30);
        print REPORTHANDLE "$Footprint $Component $Feeder\n";
        
        print "$1\t$2\t$Feeder\n";
      }
    }
    
    foreach $Key (keys %NozzleUsed)
    {
      print REPORTHANDLE "Nozzle $Key used $NozzleUsed{$Key} times\n";
    }

    close REPORTHANDLE;
}

sub GenerateTestPickupData
{
    $TotalPlaceCount = 0;
    $TotalComponentCount = 0;
    foreach $Feeder (sort keys %FeederX)
    {
        $TotalPlaceCount++;
        $TotalComponentCount++;
        $Key =$FeederToComponent{$Feeder};
        $Key =~/(.*)~(.*)/;
        $Designator = "T$TotalPlaceCount";
        $Footprint = $1;
        $Component = $2;
        $MidX = $QuadReferenceX;
        $MidY = $QuadReferenceX;
        $Rotation = 0;
        if ($ComponentFeeder{$Key} eq "")
        {
            print "Warning : No component using pickup location $Feeder\n";
            #Create unique key so that entry is still valid for pickup test
            $Key = "$Feeder~$Feeder";
            $ComponentFeeder{$Key} = $Feeder;
#            $UnPickable{$Key} ++;
#            $UnPickableDesignators{$Key} = Append($UnPickableDesignators{$Key}, $Designator);
        }
        elsif ($ComponentFeeder{$Key} ne "HAND")
        {
            if ($PlaceCount{$Key} eq "")
            {
                $UniqueComponents++;
                $IndexToKey{$UniqueComponents} = $Key;
                $KeyToIndex{$Key} = $UniqueComponents;
                $CompFootprint{$UniqueComponents} = $Footprint;
                $CompComponent{$UniqueComponents} = $Component;
                $UsedPickup{$ComponentFeeder{$Key}} = $Key;
            }
            $PlaceCount{$Key}++;
            #Origin within Altium must be set to bottom left
            #Coordinates are -ve, so invert to match Quad directions
            $MachineLocalX{$Designator} = $MidX;
            $MachineLocalY{$Designator} = $BoardHeight - $MidY;
            $PlaceMachineAbsoluteX{$TotalPlaceCount} = $QuadReferenceX;
            $PlaceMachineAbsoluteY{$TotalPlaceCount} = $QuadReferenceY;
            $PlaceComponentRotation{$TotalPlaceCount} = 0;
            $PlaceCompopnentDesignator{$TotalPlaceCount} = $Designator;
            $PlaceComponentFootprint{$TotalPlaceCount} = $Footprint;
            $PlaceComponentComponent{$TotalPlaceCount} = $Component;
            $Placeable = Append($Placeable, $Designator);
            $Nozzle = $ComponentNozzle{$Key};
            $NozzleUsed{$Nozzle}++;
        }
    }
    print "****************************************\n";
    print "* Only generating test pickup sequence *\n";
    print "****************************************\n";
}

sub GenAutoProg
{
    $PnPFilename =~/(.*)\./;
    $OutName = $1.".cad";
    $DeDupe = 1;
    open(OUTHANDLE, ">".$OutName) || die "Could not open '$OutName'";
    for ($Index = 1; $Index <= $TotalPlaceCount; $Index++)
    {
        $Footprint = $PlaceComponentFootprint{$Index};
        $Component = $PlaceComponentComponent{$Index};
        $Key = $Footprint . "~" . $Component;
        $Reference = $Index;
        $FeederID = $ComponentFeeder{$Key};
        $Designator = $PlaceCompopnentDesignator{$Index};
        if ($DesUsed{$Designator})
        {
            $Designator = "DUPE".$DeDupe;
            $DeDupe++;
        }
        $DesUsed{$Designator} = "Y";
        $PlaceX = int($PlaceMachineAbsoluteX{$Index} + $XAdjust) / 1000;
        $PlaceY = int($PlaceMachineAbsoluteY{$Index} + $YAdjust) / 1000;
        $PlaceT = ($PlaceComponentRotation{$Index} + 90 + $FeederT{$FeederID} + $ComponentOrientation{$Key}) / 0.015;
        $PlaceT = int(($PlaceT % 24000) * 0.015);
        $PlaceZ = int($QuadReferenceZ - $BoardThickness - $ComponentHeight{$Key} + $ZAdjust) / 1000;
        $NewComponent = CropLength($Key, 20);
        $NewComponent =~s/~/_/g;
        print OUTHANDLE PadSpaces($NewComponent, 34) . PadSpaces($Designator, 21) . PadSpaces($PlaceX, 9) . PadSpaces($PlaceY, 9) . PadSpaces($PlaceT, 9) . "\n";
    }
    close(OUTHANDLE);
}

sub GenAutoProgOld
{
    open(HANDLE, $PnPFilename) || die "Could not open '$PnPFilename'";
    $PnPFilename =~/(.*)\./;
    $OutName = $1.".cad";
    open(OUTHANDLE, ">".$OutName) || die "Could not open '$OutName'";
    $Data = <HANDLE>;
    $Data = <HANDLE>;
    $DeDupe = 1;
    while ($Data = <HANDLE>)
    {
        $Data =~/(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)\s*(\S*)/;
        $Des = $1;
        if ($DesUsed{$Des})
        {
            $Des = "DUPE".$DeDupe;
            $DeDupe++;
        }
        $DesUsed{$Des} = "Y";
        $Footprint = $2;
        $X = $3;
        $Y = $4;
        $TB = $9;
        $Theta = $10;
        $Comment = $11;
        $X =~/(.*)mil/;
        $X = int($1) / 1000;
        $Y =~/(.*)mil/;
        $Y = int($1) / 1000;
        $Theta =~/(.*)\.\.*/;
        $Theta = $1;
        
        if ($Comment =~/^DNP/)
        {
        }
        else
        {
            if ($TB eq $DoTopBottom)
            {
                print OUTHANDLE PadSpaces($Footprint . "_" . $Comment, 34) . PadSpaces($Des, 10) . PadSpaces($X, 8) . PadSpaces($Y, 8) . PadSpaces($Theta, 8) . "\n";
            }
        }
    }
    close OUTHANDLE;
    close HANDLE;
}

sub DeleteDIR
{
    $Dir = $_[0];
    rmtree $Dir;
    sleep(2);#Wait for the OS to update its file list
    if(-e $Dir)
    {
            die "Could not remove directory '$Dir'\n";
    }
}

sub GenerateHeadFile
{
    open(OUTHANDLE, ">Head1.set") || die "Could not open 'Head1.set'";
    printf(OUTHANDLE "%03d", $Segments + 1);
    for ($i = 0; $i < $Segments + 1; $i++)
    {
        printf(OUTHANDLE "%03d", $i);
    }
    close OUTHANDLE;
}


sub CheckName()
{
  $TestName = "DD";
  $Multiplier[0] = 1;
  $Multiplier[1] = 3;
  $Multiplier[2] = 3;
  for ($i = 0; $i < length($TestName); $i++)
  {
    $CharVal = ord(substr($TestName, $i, 1));
    $Result = $Result + ($Multiplier[$i] * $CharVal);
  }
  
  printf("%X", $Result);
  exit(-1);  
}

sub GetAllArgs()
{
  $BoardWidth = GetArg("-width", 0);
  $BoardHeight = GetArg("-height");
  $PnPFilename = uc GetArg("-input");
  $DoTopBottom = uc GetArg("-side", "T");
  $BoardName = uc GetArg("-name");
  $BoardThickness = GetArg("-thick", 63);
  $QuadDir = uc GetArg("-quad");
  $XAdjust = GetArg("-x", 0);
  $YAdjust = GetArg("-y", 0);
  $ZAdjust = GetArg("-z", 0);
  $Lifter = uc GetArg("-lifter", "N");
  $Vision = uc GetArg("-vision", "N");
  $CheckPickup = uc GetArg("-putest", "N");
  $ComponentTest = uc GetArg("-comptest", "N");
  $AutoProg = uc GetArg("-autoprog", "N");
  $FeederFile = uc GetArg("-feeder", "");
  $Format = uc GetArg("-format", "ALTIUM");
  $ReportSortMode = uc GetArg("-sort", "F");
  $YScale = GetArg("-yscale", "1.0");
  $XScale = GetArg("-xscale", "1.0");
}

sub ProcessArgs()
{
  if ($CheckPickup eq "Y")
  {
    $BoardName = "PUTEST";
    $QuadDir = "BRD25fXX.DIR";
  }
  
  
  if ($ComponentTest eq "Y")
  {
    $BoardName = "COMPONENTTEST";
    $QuadDir = "BRD60FXX.DIR";
  }
  
  if (uc $Lifter eq "Y")
  {
      $QuadReferenceZ = $QuadReferenceZLifter;
      #Coordinates of the bottom right corner of the PCB when locked in the transport
      $QuadReferenceX = 22841 + $LifterKickerX;
      $QuadReferenceY = 4760 + $LifterKickerY;
  }
  else
  {
      $QuadReferenceZ = $QuadReferenceZNoLifter;
      #Coordinates of the bottom right corner of the PCB when locked in the transport
      $QuadReferenceX = 22841;
      $QuadReferenceY = 4760;
  }
  
  $PnPFilename =~ /(.*)\..*/;
  
  if ($QuadDir eq"")
  {
      $QuadDir = $1;
  }  
}

sub GenerateAudioFile()
{
  $SampleRate = 44100;
  $ByteRate = $SampleRate * 4;
  $SilenceTime = 2.0;
  $ToneFrequency = 882;
  $SamplesPerCycle = $SampleRate / $ToneFrequency;
  $SamplesHigh = $SamplesPerCycle / 2;
  $SamplesLow = $SamplesPerCycle / 2;
  $RepeatCount = 1000;
  $ToneCycles = 50;
  $SilenceSamples = $SampleRate * $SilenceTime;
  $Subchunk2Size = (($ToneCycles * $SamplesPerCycle) + $SilenceSamples) * $RepeatCount * 2 * 2; # 2x for left/right, 2x for bytes
  $ChunkSize = $Subchunk2Size + 36;

  open(OUTPUTHANDLE, ">Square.wav") || die "Could not open 'Square.wav'";
  #Chunk descriptor
  printf(OUTPUTHANDLE "RIFF");
  #Chunk Size
  printf(OUTPUTHANDLE "%c%c%c%c", $ChunkSize & 0xff,($ChunkSize >> 8) & 0xff, ($ChunkSize >> 16) & 0xff, ($ChunkSize >> 24) & 0xff);
  #Format
  printf(OUTPUTHANDLE "WAVE");
  
  #Sub format header
  #Sub-chunk 1
  printf(OUTPUTHANDLE "fmt ");
  #Sub chunk Size (16)
  printf(OUTPUTHANDLE "%c%c%c%c", 0x10,0x00, 0x00, 0x00);
  #Audio format
  printf(OUTPUTHANDLE "%c%c", 0x01,0x00);
  #Channel count
  printf(OUTPUTHANDLE "%c%c", 0x02,0x00);
  #Sample rate
  printf(OUTPUTHANDLE "%c%c%c%c", $SampleRate & 0xff,($SampleRate >> 8) & 0xff,($SampleRate >> 16) & 0xff,($SampleRate >> 24) & 0xff);   
  #Byte rate
  printf(OUTPUTHANDLE "%c%c%c%c", $ByteRate & 0xff,($ByteRate >> 8) & 0xff,($ByteRate >> 16) & 0xff,($ByteRate >> 24) & 0xff);   
  #Block align
  printf(OUTPUTHANDLE "%c%c", 0x04,0x00);
  #Bites per sample
  printf(OUTPUTHANDLE "%c%c", 0x10,0x00);
  
  #Data sub chunk
  printf(OUTPUTHANDLE "data");
  #Sub chunk Size
  printf(OUTPUTHANDLE "%c%c%c%c", Subchunk2Size & 0xff,(Subchunk2Size >> 8) & 0xff, (Subchunk2Size >> 16) & 0xff, (Subchunk2Size >> 24) & 0xff);

  #Sample data
  for (my $l = 0; $l < $RepeatCount; $l++)
  {
    for (my $j = 0; $j < $ToneCycles; $j++)
    {
      #Send high
      for (my $i = 0; $i < $SamplesHigh * 2; $i++) #2x for left & right
      {
        printf(OUTPUTHANDLE "%c%c", 0xff,0x7f);   
      }
      #Send low
      for (my $i = 0; $i < $SamplesLow * 2; $i++) #2x for left & right
      {
        printf(OUTPUTHANDLE "%c%c", 0x00,0x80);   
      }
    }
    #Send silence period
    for (my $i = 0; $i < $SilenceSamples * 2; $i++) #2x for left & right
    {
      printf(OUTPUTHANDLE "%c%c", 0x00,0x00);   
    }
  }
 
  printf(OUTPUTHANDLE "%c%c", 0,0);   
  close(OUTPUTHANDLE);
}

#//GenerateAudioFile();
#exit(0);

########################################################
# Main program start
########################################################

GetAllArgs();

ProcessArgs();

if (CheckArguments() == 0)
{
    if (-e "FeederPickupReels.txt")
    {
        ReadFeederPickup("FeederPickupReels.txt");
    }
    if ($FeederFile ne "")
    {
        ReadFeederPickup("$FeederFile");
    }
    ReadComponentFeeders("ComponentFeeders.txt");
#    ReadAllFeederFiles();
    ReadChucks();
    if ($CheckPickup eq "Y")
    {
        GenerateTestPickupData();
    }
    else
    {
      if ($Format eq "ALTIUM")
      {
        $Scale = 1.0;
        ReadPnPDataAltium();
      }
      elsif ($Format eq "KICAD")
      {
        $Scale = 39.3700787401575;
        $BoardWidth = $BoardWidth * $Scale;
        $BoardHeight = $BoardHeight * $Scale;
        ReadPnPDataKiCad();
      }
      else
      {
        
      }
    }
    
    print "Building sequence list.\n";
    BuildSequenceList();

    if (uc $AutoProg eq "Y")
    {
        print "Only generating Autogen data\n";
        GenAutoProg();
    }
    else
    {
        print "Generating Quad data\n";
    
        DeleteDIR($QuadDir);
        mkdir $QuadDir;
        chdir $QuadDir;
    
        if ($BoardName ne "")
        {
            CreateBoardNameFile();
        }
    
        
        print "Generating BRDATA1.DAT file.\n";
        GenerateBRDATA1();
#        if ($Segments != 1)
        if ($Segments != 0)#STEVE FIX FOR MULTI_SEGMENT
        {
            #Multiple segments so create head1.dat file
            GenerateHeadFile();
        }
    }

    if ($TotalSequencesSent != $TotalSequenceCount)
    {
        print "Sequence sent count error\n";
    }
    print "Generating report.\n";
    GenerateReport();
    
    if ($UniqueComponents > 127)
    {
        print "Warning : Too many unique components. $UniqueComponents found.\n";
    }
    print "$UniqueComponents unique pickable components.\n";
    
    foreach $Key (keys %UnPickable)
    {
        $TimesUsed = $UnPickable{$Key};
        print "Warning : No feeder defined for component $Key, used $TimesUsed times ($UnPickableDesignators{$Key}).\n";
    }
    print "Placed $TotalPlaceCount components out of $TotalComponentCount total components in $TotalSequenceCount sequence steps.\n";
    print "Output Quad directory = '$QuadDir', board name = '$BoardName'.\n";
    if (($PickupAdjustX != 0) or ($PickupAdjustY !=0) or ($PickupAdjustZ != 0))
    {
      print"***************WARNING : PICKUP OFFSETS NON-ZERO***************\n";
    }

    print "Finished.\n";

}
else
{
    DisplayHelp();
}
