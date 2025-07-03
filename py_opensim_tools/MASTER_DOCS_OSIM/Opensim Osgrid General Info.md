SecondLife.exe --loginuri http://login.osgrid.org/ --loginpage http://www.osgrid.org/splash/

@echo off > osurl.bat
SET rawUrl=%1
SET cleanUrl=%rawUrl:~10%
START "OpenSim" /HIGH /B "%~d0%~p0SecondLifeWindLight.exe" -loginpage %cleanUrl%?method=login -loginuri %cleanUrl%
EXIT


Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim]
"(default)"="URL:opensim"
"URL Protocol"=""
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim\DefaultIcon]
@="\"C:\\Program Files\\SecondLifeWindLight\\osurl.bat\""
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim\shell]
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim\shell\open]
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim\shell\open\command]
[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\opensim\shell\open\command]
@="\"C:\\Program Files\\SecondLifeWindLight\\osurl.bat\" %1"


http://www.hyperica.com/
https://www.osgrid.org/download.php
https://www.osgrid.org/simulators.php
https://www.osgrid.org/map.php
https://www.osgrid.org/quickmap.php?resolution=8
https://opensimworld.com/usersignup

OpenSim.Region.Framework.Scenes.Scene is the "heart" of OpenSimulator's functionality. The method Scene.Heartbeat() starts the heartbeat going; it does this by calling the Update() method. That method is the "main loop" of the region:

public override void Update()
        {
            int maintc = 0;
            while (!shuttingdown)
            {
That loop is run over and over again. At the bottom of the loop is:

maintc = Environment.TickCount - maintc;
                maintc = (int)(m_timespan * 1000) - maintc;
 
                if ((maintc < (m_timespan * 1000)) && maintc > 0)
                    Thread.Sleep(maintc);
            }
        }


4 tips for setting a welcome region   BY MARIA KOROLOV · JULY 21, 2014

SkyLife Grid’s welcome region.
A grid’s welcome region is like the home page of a website. It’s where new users arrive for the first time, and where hypergrid travelers land if all they know is the grid’s loginURI.

For example, OSgrid’s welcome region is LBSA Plaza. Its full hypergrid address is hg.osgrid.org:80:lbsa plaza  but hg.osgrid.org:80 works just as well, which is very convenient, especially if the region has a very long name or your would-be travelers don’t know what the name of your welcome region is.

Not every grid is considerate enough to name its welcome region “Welcome.”

This issue recently came up when hypergrid travelers tried visiting SkyLife Grid, which has login.skylifegrid.com:8002:SkyLife Welcome Center @ FreeDom City as its welcome region. Yes, the whole thing — including the “@” sign — is the address.

Unfortunately, the shorter login.skylifegrid.com:8002 address wasn’t working.

I checked with Dierk Brunner, CEO of Dreamland Metaverse, for some advice for grid owners about how to actually go about setting a region to be a welcome region. (But all mistakes below are my own!)

This applies both for full grids as well as mini-grids running on the Diva Distro, Sim-on-a-Stick or New World Studio versions of OpenSim.
a

1. Find [GridService] settings

If you’re running a full grid, using the Robust central grid services, this will be in your Robust.ini file.

For minigrids, it should be in your MyWorld.ini file, in the config-include folder.

You might have to hunt around for this file.

2. Find the default region line

In Robust.ini, this line looks something like this: ; Region_Welcome_Area = “DefaultRegion, FallbackRegion”

In version of New World studio, it looks like this: Region_My_World_1 = “DefaultRegion, FallbackRegion”

You can do a simple text search for “DefaultRegion” or “FallbackRegion” to find it.

3. Change it to reflect name of your actual welcome region

Let’s say that your welcome region is named “Betty Boop.”

You would change the line to this: Region_Betty_Boop =  “DefaultRegion, DefaultHGRegion, FallbackRegion”

Note that the space in “Betty Boop” has been replaced by an underscore, and that “DefaultHGRegion” was added to the definitions.

You could also have different regions as the default login region, the default hypergrid region, and the default fallback region in case the regular welcome region is down.

4. Check to make sure hypergrid visitors aren’t blocked

OpenSim allows grid owners to prevent hypergrid visitors from visiting particular regions.

This is specified in the [AuthorizationService] section of the GridCommons.ini file in full grids, and DivaPreferences.ini in minigrids.

Last updated by Maria Korolov at July 21, 2014.

