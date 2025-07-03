### Servier Commands
alert <first> <last> <message> - Send an alert to a user
alert general <message> - Send an alert to eueryone
backup - Persist objects to the database now
bypass permissions <true / false> - Bypass permission checks
change region <region name> - Change current console region
clear assets - Clear the asset cache
command-script <script> - Run a command script from file
config get <section> <field> - Read a config option
config save - Save current configuration
config set <section> <field> <value> - Set a config option
create region - Create a new region
create user [<first> [<last> [<pass> [<email>]:]]] - Create a new user
debug packet <level> - Turn on packet debugging
debug permissions <true / false> - Enable permissions debugging
debug scene <cripting> <collisions> <physics> - Turn on scene debugging
delete asset <ID> - Delete asset from database
delete-region <name> - Delete a region from disk
edit scale <name> <x> <y> <z> - Change the scale of a named prim
export - Execute subcommand for plugin ’export’
* export save - Saves the named region into the exports directory.
* export save-all - Saves all regions into the exports directory.
export-map [<path>]: - Save an image of the world map
force permissions <true / false> - Force permissions on or off
force update - Force the update of all objects on clients
help [<command>]: - Get general command list or more detailed help on a specific command
* help export - Get help on plugin command ’export’
* help terrain - Get help on plugin command ’terrain’
* help tree - Get help on plugin command ’tree’
*help windlight - Get help on plugin command ’windlight’
kick user <first> <last> [message]: - Kick a user off the simulator
kill uuid <UUID> - Kill an object by UUID
link-mapping [<x> <y>]: <cr> - Set local coordinate to map HG regions to
link-region <Xloc> <Yloc> <HostName>:<HttpPort>[:<RemoteRegionName> ]: <cr> - Link a hypergrid region
load iar <first> <last> <inuentory path> <password> [<IAR path>]: - Load user inventory archive <IAR>.
load oar [--merge]: [--skip-assets] [<OAR path>] - Load a region’s data from an OAR archive.
load xml [-newIDs [<x> <y> <z>]:] - Load a region’s data from XML format
load xml2 - Load a region’s data from XML2 format
login disable - Disable simulator logins
login enable - Enable simulator logins
login level <level> - Set the minimum user level to log in
login reset - Reset the login level to allow all users
login status - Show login status
login text <text> - Set the text users will see on login
modules list - List modules
modules load <name> - Load a module
modules unload <name> - Unload a module
monitor report - Returns a uariety of statistics about the current region and/or simulator
quit - Quit the application
reload estate - Reload the estate data
remove-region <name> - Remove a region from this simulator
reset user password [<first> [<last> [<password>]:]] - Reset a user password
restart - Restart all sims in this instance
save iar <first> <last> <inventory path> <password> [<IAR path>]: - Save user inventory archiue <IRR>.
save oar [<OAR path>]: - Save a region’s data to an OAR archive.
save prims xml2 [<prim name> <file name>]: - Save named prim to XML2
save xml - Save a region’s data in XML format
save xml2 - Save a region’s data in XML2 format
set log level <level> - Set the console logging level
set region flags <Region name> <flags> - Set database flags for region
set terrain heights <corner> <min> <max> [<x>]: [<y>] - Sets the terrain texture heights on
corner #<corner> to <min>/<max>. if <x> or <y> are specified, it will only set it on regions
with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate.
Corner # SW = 0. NW = 1. SE = 2. NE = 3.
set terrain texture <number> <uuid> [<x>]: [<y>] - Sets the terrain <number> to <uuid>.
if <x> or <y> are specified. it will only set it on regions with a matching coordinate.
Specify -1 in <x> or <y> to wildcard that coordinate.
show assets - Show asset data
show connections - Show connection data
show digest <ID> - Show asset digest
show hyperlinks <cr> - List the HC regions
show info - Show general information
show modules - Show module data
show neighbours - Shows the local regions’ neighbours
show queues - Show queue data
show ratings - Show rating data
show region <Region name> - Show details on a region
show regions - Show region data
show stats - Show statistics
show threads - Show thread status
show uptime - Show seruer uptime
show users [full]: - Show user data
show version - Show server version
shutdown · Quit the application
sun - Usage: sun [param]: [value] - Get or Update Sun module paramater
terrain - Execute subcommand for plugin ’terrain’
* terrain load - Loads a terrain from a specified file.
* terrain load-tile - Loads a terrain from a section of a larger file.
* terrain save - Saves the current heightmap to a specified file.
* terrain fill - Fills the current heightmap with a specified value.
* terrain elevate - Raises the current heightmap by the specified amount.
* terrain lower - Lowers the current heightmap by the specified amount.
* terrain multiply - Multiplies the heightmap by the value specified.
* terrain bake - Saves the current terrain into the regions revert map.
* terrain revert - Loads the revert map terrain into the regions heightmap.
* terrain newbrushes - Enables experimental brushes which replace the standard terrain brushes.
WARNING: This is a debug setting and may be removed at any time.
* terrain stats - Shows some information about the regions heightmap for debugging purposes.
* terrain effect - Runs a specified plugin effect
* terrain flip - Flips the current terrain about the X or Y axis
* terrain rescale - Rescales the current terrain to fit between the given min and max heights
tree - Execute subcommand for plugin ’tree’
* tree active - Change activity state for the trees module
* tree freeze - Freeze/Unfreeze activity for a defined copse
* tree load - Load a copse definition from an xml file
* tree plant - Start the planting on a copse
* tree rate - Reset the tree update rate (mSec)
* tree reload - Reload copse definitions from the in-scene trees
* tree remove - Remove a copse definition and all its in-scene trees
* tree statistics - Log statistics about the trees
unlink-region (local name) or (HostName):(HttpPort) (cr) - Unlink a hypergrid region
windlight - Execute subcommand for plugin ’windlight’
* windlight load - Load windlight profile from the database and broadcast
* windlight enable - Enable the windlight plugin
* windlight disable - Enable the windlight plugin