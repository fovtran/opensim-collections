### Simulator Commands
General
change region <region name> - subsequent commands apply only to the specified region. If region name is "root" then all regions are selected
debug packet <level> - Turn on packet debugging, where OpenSimulator prints out summaries of incoming and outgoing packets for viewers, depending on the level set
emergency-monitoring - turn emergency debugging monitoring mode on or off.
help [<command>] - Get general command list or more detailed help on a specific command or set of commands
link-mapping - Set a local grid co-ordinate to link to a remote hypergrid
link-region - Link a HyperGrid region. Not sure how this differs from link-mapping
modules list - List modules
modules load <name> - Load a module
modules unload <name> - Unload a module
monitor report - Returns a variety of statistics about the current region and/or simulator
set terrain heights <corner> <min> <max> [<x>] [<y>] - Sets the terrain texture heights on corner #<corner> to <min>/<max>, if <x> or <y> are specified, it will only set it on regions with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate. Corner # SW = 0, NW = 1, SE = 2, NE = 3.
set terrain texture <number> <uuid> [<x>] [<y>] - Sets the terrain <number> to <uuid>, if <x> or <y> are specified, it will only set it on regions with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate.
show caps - show all registered capabilities URLs
NOTE: In OpenSimulator 0.7.1, "show capabilities" is shown as a result for help command, but actually only "show caps" will be accepted. (#5467)
set water height # - sets the height simulator wide or single region if you use change region.
show circuits - Show agent circuit data
show connections - show connections data
show http-handlers - show all registered http handlers
show hyperlinks - list hg regions
show modules - show module data
show pending-objects - show number of objects in the pending queues of all viewers
show pqueues [full] - show priority queue data for each client. Without the 'full' option, only root agents are shown. With the 'full' option child agents are also shown.
show queues - Show queue data for agent connections.
show threads - shows the persistent threads registered with the system. Does not include threadpool threads.
show throttles [full] - Show throttle data for each client connection, and the maximum allowed for each connection by the server. Without the 'full' option, only root agents are shown. With the 'full' option child agents are also shown.
unlink-region <local name> - unlink a hypergrid region
Appearance Commands
appearance find <uuid-or-start-of-uuid> - Find out which avatar uses the given asset as a baked texture, if any.
appearance rebake <first-name> <last-name> - Send a request to the user's viewer for it to rebake and reupload its appearance textures.
appearance send [<first-name> <last-name>] - Send appearance data for each avatar in the simulator to other viewers.
appearance show [<first-name> <last-name>] - Show appearance information for avatars.
Only exists in development code at the moment.

Archive Commands
load iar <first> <last> <inventory path> <password> [<archive path>] - Load user inventory archive. See Inventory Archives.
load oar [filename] - load an OpenSimulator archive. This entirely replaces the current region. Default filename is region.oar. See OpenSim Archives.
load xml [-newIDs [<x> <y> <z>]] - Load a region's data from XML format (0.7.*: DEPRECATED and may be REMOVED soon. Use "load xml2" instead)
those xml are the result of the export save or *export save-all
load xml2 [filename] - optional parameters not supported for XML2 format as at 1-Jul-2008
save iar <first> <last> <inventory path> <password> [<archive path>] - Save user inventory archive. See Inventory Archives
save oar [filename] - save the current region to an OpenSimulator archive. Default filename is region.oar. See OpenSim Archives.
save prims xml2 [<prim name> <file name>] - Save named prim to XML2
save xml [filename] - save prims to XML
save xml2 [filename] - save prims to XML (Format 2 - rearrangement of some nodes, to make loading/saving easier)
Asset Commands
The fcache commands only currently appearance if you are using the fcache asset cache. This is the default on OpenSimulator.

fcache assets - Attempt a deep scan and cache of all assets in all scenes
fcache clear [file] [memory] - Remove all assets in the cache. If file or memory is specified then only this cache is cleared.
fcache clearnegatives - just clear negative cache entries if enabled
fcache expire <datetime> - Purge cached assets older then the specified date/time
fcache status - Display cache status
j2k decode <ID> - Do JPEG2000 decoding of an asset.
Config Commands
config get [<section>] [<key>] - Get the current configuration, either for a particular key, a particular section or the whole config.
config save <path> - Save the current configuration to a file.
config set <section> <key> - Set a particular configuration value. On the whole, this is useless since neither OpenSimulator nor modules dynamically reload config values.
config show [<section>] [<key>] - Synonym for 'config get'
Land Commands
land show - Shows all parcels on the current region.
land clear - Clears all parcels on the land.
Map Commands
export-map [<path>] - Save an image of the world map (default name is exportmap.jpg)
generate map - Regenerates and stores map tile. Only in development code post 0.7.6.
Object Commands
backup - Persist currently unsaved object changes immediately instead of waiting for the normal persistence call. This shouldn't normally be required - the simulator persists region objects automatically at regular intervals and on shutdown.
delete object creator <UUID> - Delete a scene object by creator
delete object name [--regex] <name> - Delete a scene object by name.
delete object outside - Delete all scene objects outside region boundaries. This is currently if z < 0 or z > 10000. Object outside these bounds have been known to cause issues with OpenSimulator's use of some physics engines (such as the Open Dynamics Engine).
delete object owner <UUID> - Delete a scene object by owner
delete object id <UUID-or-localID> - Delete a scene object by uuid or localID. Pre 0.7.5, this was "delete object uuid".
dump object id <UUID-or-localID> - Dump the serialization of the given object to a file for debug purposes.
edit scale <name> <x> <y> <z> - Change the scale of a named prim
force update - Force the region to send all clients updates about all objects.
show object name [--regex] <name> - Show details of scene objects with the given name.
show object id <UUID-or-localID> - Show details of a scene object with the given UUID or localID. Pre 0.7.5, this was "show object uuid".
show part name [--regex] <name> - Show details of scene object parts with the given name.
show part id <UUID-or-localID> - Show details of a scene object parts with the given UUID or localID. Pre 0.7.5, this was "show part uuid".
Estate Commands
reload estate - reload estate data
estate link region <estate ID> <region ID> - Attaches the specified region to the specified estate.
estate show - This command will show the estate name, ID, and owner for regions currently running in the simulator. This list does not necessarily include all estates that are present in the database.
Sample usage:

estate show<enter>
Estate information for region TestRegion
Estate Name ID Owner
My Estate 103 Test User
estate set name <estate ID> <new name> - Rename an estate
estate set owner <estate ID> <FirstName> <LastName> - Change the owner of an estate. This command supports two forms; this one uses the owner's name.
estate set owner <estate ID> <owner UUID> - Change the owner of an estate. This command supports two forms; this one uses the owner's UUID.
estate create <owner UUID> <estate name> - Must be a user UUID which you can get from 'show names'
Region Commands
change region <region name> - subsequent commands apply only to the specified region. If region name is "root" then all regions are selected
create region [name] [filename] - Create a new region
delete-region <name> - Delete a region from disk.
region get - Post OpenSimulator 0.8.0.*. Show region parameters (Region Name, Region UUID, Location, URI, Owner ID, Flags).
region restart abort [<message>] - Abort a scheduled region restart, with an optional message
region restart bluebox <message> <delta seconds>+ - Schedule a region restart. If one delta is given then the region is restarted in delta seconds time. A time to restart is sent to users in the region as a dismissable bluebox notice. If multiple deltas are given then a notice is sent when we reach each delta.
region restart notice <message> <delta seconds>+ - Schedule a region restart. Same as above except showing a transient notice instead of a dismissable bluebox.
region set - Post OpenSimulator 0.8.0.*. Set certain region parameters. Currently, can set
agent-limit - The current avatar limit for the region. More usually this is set via the region/estate dialog in a typical viewer. This persists over simulator restarts.
max-agent-limit - The maximum value that agent-limit can have. Unfortunately, setting it here does not currently persist over server restarts. For that to happen it must be separately set as the MaxAgents parameter in the region config file.
remove-region - remove a region from the simulator
restart - Restarts all sims in this instance
restart region <regionname> - Restarts just one sim in an instance. Set the console to the region name first, with 'change region <regionname>', or all regions will restart.
set region flags <Region name> <flags> - Set database flags for region
Flags can be one of the following:
DefaultRegion Used for new Rez. Random if multiple defined
FallbackRegion Regions we redirect to when the destination is down
RegionOnline Set when a region comes online, unset when it unregisters and DeleteOnUnregister is false
NoDirectLogin Region unavailable for direct logins (by name)
Persistent Don't remove on unregister
LockedOut Don't allow registration
NoMove Don't allow moving this region
Reservation This is an inactive reservation
Authenticate Require authentication
Hyperlink Record represents a HG link
DefaultHGRegion Record represents a default region for hypergrid teleports only.
Note: flags are additive, there is no way to unset them from the console.
show neighbours - Shows the local regions' neighbours
show ratings - Show rating data
show region - Show region parameters (Region Name, Region UUID, Location, URI, Owner ID, Flags).
show regions - Show regions data (Region Names, XLocation YLocation coordinates, Region Ports, Estate Names)
Scene Commands
debug scene - Turn on scene debugging
rotate scene <degrees> - Rotates scene around 128,128 axis by x degrees where x=0-360.
scale scene <factor> - Scales all scene objects by a factor where original size =1.0.
translate scene <x,y,z> - Translate (move) the entire scene to a new coordinate. Useful for moving a scene to a different location on either a Mega or Variable region.
(please back up your region before using any of these commands and be aware of possible floating point errors the more they are used.)

Script Commands
These currently only exist in git master OpenSimulator development code post the 0.7.2 release.

scripts resume [<script-item-uuid>] - Resumes all suspended scripts
scripts show [<script-item-uuid>] - Show script information. <script-item-uuid> option only exists from git master 82f0e19 (2012-01-14) onwards (post OpenSimulator 0.7.2).
scripts start [<script-item-uuid>] - Starts all stopped scripts
scripts stop [<script-item-uuid>] - Stops all running scripts
scripts suspend [<script-item-uuid>] - Suspends all running scripts
Stats Commands
show stats - show useful statistical information for this server. See Frame Statistics Values below for more information.
stats show - a synonym for "show stats" (OpenSimulator dev code only post 19th March 2014).
stats record - record stats periodically to a separate log file.
stats save - save a snapshot of current stats to a file (OpenSimulator dev code only post 19th March 2014).
Terrain Commands
Some of these may require a sim restart to show properly.

terrain load - Loads a terrain from a specified file. (see note1)
terrain load-tile - Loads a terrain from a section of a larger file.
terrain save - Saves the current heightmap to a specified file.
terrain save-tile - Saves the current heightmap to the larger file.
terrain fill - Fills the current heightmap with a specified value.
terrain elevate - Raises the current heightmap by the specified amount.
terrain lower - Lowers the current heightmap by the specified amount.
terrain multiply - Multiplies the heightmap by the value specified.
terrain bake - Saves the current terrain into the regions baked map.
terrain revert - Loads the baked map terrain into the regions heightmap.
terrain newbrushes - Enables experimental brushes which replace the standard terrain brushes.
terrain show - Shows terrain height at a given co-ordinate.
terrain stats - Shows some information about the regions heightmap for debugging purposes.
terrain effect - Runs a specified plugin effect
terrain flip - Flips the current terrain about the X or Y axis
terrain rescale - Rescales the current terrain to fit between the given min and max heights
terrain min - Sets the minimum terrain height to the specified value.
terrain max - Sets the maximum terrain height to the specified value.
terrain modify - Provides several area-of-effect terraforming commands.
Note1 : If you have a sim with multiple regions and you want to set all regions on that sim to be from one larger image you can use 'terrain load <file> <width in regions> <height in regions> <regionX> <regionY> where regionX and regionY are the coordinates of the bottom-left region.

Tree Commands
tree active - Change activity state for the trees module
tree freeze - Freeze/Unfreeze activity for a defined copse
tree load - Load a copse definition from an xml file
tree plant - Start the planting on a copse
tree rate - Reset the tree update rate (mSec)
tree reload - Reload copse definitions from the in-scene trees
tree remove - Remove a copse definition and all its in-scene trees
tree statistics - Log statistics about the trees
User Commands
alert <message> - send an in-world alert to everyone
alert-user <first> <last> <message> - send an an in-world alert to a specific user
bypass permissions <true / false> - Bypass in-world permission checks
debug permissions - Turn on permissions debugging
force permissions - Force permissions on or off.
kick user <first> <last> [message]: - Kick a user off the simulator
login disable - Disable user entry to this simulator
login enable - Enable user entry to this simulator
login status - Show whether logins to this simulator are enabled or disabled
show users [full]- show info about currently connected users to this region. Without the 'full' option, only users actually on the region are shown. With the 'full' option child agents of users in neighbouring regions are also shown.
teleport user <destination> - Teleport a user on this simulator to a specific destination. Currently only in OpenSimulator development code after the 0.7.3.1 release (commit bf0b817).
Windlight/LightShare Commands
windlight load - Load windlight profile from the database and broadcast
windlight enable - Enable the windlight plugin
windlight disable - Disable the windlight plugin
YEngine Commands
yeng help
yeng reset -all | <part-of-script-name>
yeng resume - resume script processing
yeng suspend - suspend script processing
yeng ls -full -max=<number> -out=<filename> -queues -topcpu
yeng cvv - show compiler version value
yeng mvv [<newvalue>] - show migration version value
yeng tracecalls [yes | no]
yeng verbose [yes | no]
yeng pev -all | <part-of-script-name> <event-name> <params...>
