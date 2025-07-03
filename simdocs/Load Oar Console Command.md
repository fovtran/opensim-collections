### Load Oar Console Command
Once you have saved regions in OAR files, the 'load oar' console command will load the OAR file into the current region. There are many parameters that enable replacing the region's current contents or merging the OAR file's contents with the objects and terrain already in the region.

Note: As of Opensimulator 0.9.0-dev the 'load oar' has changed slightly in order to support more features. Please see the Load Oar 0.9.0+ page.
Note 2: For more discussion about OpenSimulator archives please have a look at the OpenSim Archives page.

Parameters
The load oar command has the format:

load oar [parameters] OARFILE
where "OARFILE" is the path to the OAR file to read in, and "[parameters]" is zero or more optional parameters from the following list:

Parameter	Since	Description
--merge	0.6.8	Specify to merge the contents of the reading OAR with the existing contents in the region.
--skip-assets	0.6.9	If set, this will not load any of the assets from the OAR, though all other data will be loaded. This saves a lot of time and database operations if loading an OAR multiple times on a grid -- specify --skip-assets after the first time the OAR is loaded on a grid as the assets would have already been loaded the first time the OAR files was loaded.
--displacement	0.8	Specify a displacement that is added to all objects in the OAR file as they are added to the region. The displacement MUST be specified as "<x,y,z>". So, for instance, to load an OAR from a 256x256 region into the middle of a larger 512x512 region, the parameter would be --displacement "<128,128,0>". Note that you can specify a "Z" displacement which will move the objects up or down. Thus --displacement "<0,0,1000>" will put all the OAR's objects up high for a sky box.
The displacement is also applied to the terrain if it is included. The 'z' component is added to the terrain's heights.

--rotation	0.8	The degrees to rotate all the objects loaded from the OAR.
--rotation-center	0.8	The center around which to rotate objects on load. NOTE: As of 0.8.1 this does nothing and will be removed soon.
--no-objects	0.8	Don't load any scene objects.
--force-terrain	0.8	Force terrain loading on --merge. Normally, --merge does not overwrite the existing region's terrain.
--force-parcels	0.8	Force parcel loading on --merge. Normally, --merge does not overwrite the existing region's parcel data.
--default-user "<first-name> <last-name>"	0.8	Instead of setting object ownership to the estate owner, assign it to the named user. This only applies to objects that have UUIDs that do not match any user account in the receiving grid's installation. There is currently no option that will force a change of owner for all loaded objects no matter whether they match a user in the receiving installation. One workaround to achieve this would be to save the OAR with the --publish "save oar" option to strip owner information and then reload it.
--debug	0.8.1	Force the archiver to display messages about where each object is being placed.
Notes On Regions of Different Sizes
With the addition of regions that have a size that can be a multiple of 256x256 (i.e. a Varregion) there is the possibility of loading OARs to and from regions of different sizes. In general, loading an OAR from a smaller region into a larger region will do what you expect. Trying to load a larger region into a smaller region will generate many errors although, if you have adjacent smaller regions, some of the objects will be loaded into the adjacent regions. Try at your own risk.

Example Uses
Replacing a region's contents with what's in an OAR file
Replacing a region with an OAR file for a region of the same size is as simple as:

load oar NewRegion.oar
Merging together four region's worth of contents
Say you have four adjacent 256x256 region ('Region00.oar', 'Region01.oar', ...) and you want to load them into a new 512x512 Varregion ('BiggerRegion'). The commands would be:

change region BiggerRegion
load oar Region0.oar
load oar --merge --force-terrain --displacement <0,256,0> Region01.oar
load oar --merge --force-terrain --displacement <256,0,0> Region10.oar
load oar --merge --force-terrain --displacement <256,256,0> Region11.oar
Loading a 256x256 region's contents into the middle of a 512x512 sized region
If you have an OAR file for a 256x256 region ('LegacyRegion.oar' for instance) and you want to set it into the middle of a 512x512 region with the loaded region rotated by 30 degrees without messing up the rest of the larger region, the command would be:

load oar --merge --force-terrain --force-parcels --displacement <128,128,0> --rotation 30.0 --rotation-center <128,128,0> LegacyRegion.oar
Notes
As seen in irc :

<shomon> hi nebadon are you there? I am trying to install the universal campus, and got some out of memory error that crashed my server even with 4gb of ram.. And I don't know where to send the error.
<shomon> or report it.. also I imported all the oars within a single varregion so maybe I could also add that code to a page somewhere so others don't have to..

<nebadon> try disable xengine and set physics to basic in OpenSim.ini
<nebadon> then load the oar
<nebadon> once oar finishes type "backup" on the console 
<nebadon> and wait for console to return
<nebadon> then shut it down and re-enable stuff