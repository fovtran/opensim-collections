OpenSim
Archiving
load iar [-m|–merge] <Vorname> <Nachname> <inventory path> <password> [<IAR path>] – Load user inventory archive (IAR).

load oar [-m|–merge] [-s|–skip-assets] [–default-user “User Name”] [–force-terrain] [–force-parcels] [–no-objects] [–rotation degrees] [–bounding-origin “<x,y,z>”] [–bounding-size “<x,y,z>”] [–displacement “<x,y,z>”] [-d|–debug] [<OAR path>] – Load a region’s data from an OAR archive.

load xml [-newIDs [<x> <y> <z>]] – Load a region’s data from XML format

load xml2 – Load a region’s data from XML2 format

save iar [-h|–home=<url>] [–noassets] <Vorname> <Nachname> <inventory path> <password> [<IAR path>] [-c|–creators] [-e|–exclude=<name/uuid>] [-f|–excludefolder=<foldername/uuid>] [-v|–verbose] – Save user inventory archive (IAR).

save oar [-h|–home=<url>] [–noassets] [–publish] [–perm=<permissions>] [–all] [<OAR path>] – Save a region’s data to an OAR archive.

save prims xml2 [<prim name> <file name>] – Save named prim to XML2

save xml – Save a region’s data in XML format

save xml2 – Save a region’s data in XML2 format

Assets
dump asset <id> – Dump an asset

fcache assets – Attempt a deep scan and cache of all assets in all scenes

fcache clear [file] [memory] – Remove all assets in the cache. If file or memory is specified then only this cache is cleared.

fcache expire <datetime> – Purge cached assets older then the specified date/time

fcache status – Display cache status

j2k decode <ID> – Do JPEG2000 decoding of an asset.

show asset <ID> – Show asset information

Comms
clear image queues <Vorname> <Nachname> – Clear the image queues (textures downloaded via UDP) for a particular client.

show caps list – Shows list of registered capabilities for users.

show caps stats by cap [<cap-name>] – Shows statistics on capabilities use by capability.

show caps stats by user [<Vorname> <Nachname>] – Shows statistics on capabilities use by user.

show circuits – Show agent circuit data

show client stats [Vorname Nachname] – Show client request stats

show connections – Show connection data

show http-handlers – Show all registered http handlers

show image queues <Vorname> <Nachname> – Show the image queues (textures downloaded via UDP) for a particular client.

show pending-objects – Show # of objects on the pending queues of all scene viewers

show pqueues [full] – Show priority queue data for each client

show queues [full] – Show queue data for each client

show throttles [full] – Show throttle settings for each client and for the server overall

Debug
debug attachments log [0|1] – Turn on attachments debug logging

debug attachments status – Show current attachments debug status

debug attachments throttle <ms> – Turn on attachments throttling.

debug comms set serialosdreq true|false – Set comms parameters. For debug purposes.

debug comms status – Show current debug comms parameters.

debug eq [0|1|2] – Turn on event queue debugging

 <= 0 - turns off all event queue logging
 >= 1 - turns on event queue setup and outgoing event logging
 >= 2 - turns on poll notification
debug http <in|out|all> [<level>] – Turn on http request logging.

debug jobengine <start|stop|status|log> – Start, stop, get status or set logging level of the job engine.

debug permissions <true / false> – Turn on permissions debugging

debug scene get – List current scene options.

debug scene set <param> <value> – Turn on scene debugging options.

debug scripts log <item-id> <log-level> – Extra debug logging for a particular script.

debug threadpool level 0..3 – Turn on logging of activity in the main thread pool.

debug threadpool set worker|iocp min|max <n> – Set threadpool parameters. For debug purposes.

debug threadpool status – Show current debug threadpool parameters.

debug xengine log [<level>] – Turn on detailed xengine debugging.

force gc – Manually invoke runtime garbage collection. For debugging purposes

show eq – Show contents of event queues for logged in avatars. Used for debugging.

show threadpool calls complete – Show details about threadpool calls that have been completed.

threads abort <thread-id> – Abort a managed thread. Use “show threads” to find possible threads.

Estates
estate create <owner UUID> <estate name> – Creates a new estate with the specified name, owned by the specified user. Estate name must be unique.

estate link region <estate ID> <region ID> – Attaches the specified region to the specified estate.

estate set name <estate-id> <new name> – Sets the name of the specified estate to the specified value. New name must be unique.

estate set owner <estate-id>[ <UUID> | <Firstname> <Lastname> ] – Sets the owner of the specified estate to the specified UUID or user.

estate show – Shows all estates on the simulator.

Friends
friends show [–cache] <Vorname> <Nachname> – Show the friends for the given user if they exist.

General
change region <region name> – Change current console region

command-script <script> – Run a command script from file

config get [<section>] [<key>] – Synonym for config show

config save <path> – Save current configuration to a file at the given path

config set <section> <key> <value> – Set a config option. In most cases this is not useful since changed parameters are not dynamically reloaded. Neither do changed parameters persist – you will have to change a config file manually and restart.

config show [<section>] [<key>] – Show config information

get log level – Get the current console logging level

monitor report – Returns a variety of statistics about the current region and/or simulator

quit – Quit the application

set log level <level> – Set the console logging level for this session.

show checks – Show checks configured for this server

show info – Show general information about the server

show modules – Show module data

show stats [list|all|(<category>[.<container>])+ – Alias for ‘stats show’ command

show threads – Show thread status

show uptime – Show server uptime

show version – Show server version

shutdown – Quit the application

stats record start|stop – Control whether stats are being regularly recorded to a separate file.

stats save <path> – Save stats snapshot to a file. If the file already exists, then the report is appended.

stats show [list|all|(<category>[.<container>])+ – Show statistical information for this server

threads show – Show thread status. Synonym for “show threads”

Hypergrid
link-mapping [<x> <y>] – Set local coordinate to map HG regions to

link-region <Xloc> <Yloc> <ServerURI> [<RemoteRegionName>] – Link a HyperGrid Region. Examples for <ServerURI>: http://grid.net:8002/ or http://example.org/path/foo.php

show hyperlinks – List the HG regions

unlink-region <local name> – Unlink a hypergrid region

Land
land clear – Clear all the parcels from the region.

land show [<local-land-id>] – Show information about the parcels on the region.

Objects
backup – Persist currently unsaved object changes immediately instead of waiting for the normal persistence call.

delete object creator <UUID> – Delete scene objects by creator

delete object id <UUID-or-localID> – Delete a scene object by uuid or localID

delete object name [–regex] <name> – Delete a scene object by name.

delete object outside – Delete all scene objects outside region boundaries

delete object owner <UUID> – Delete scene objects by owner

delete object pos <start-coord> to <end-coord> – Delete scene objects within the given area.

dump object id <UUID-or-localID> – Dump the formatted serialization of the given object to the file <UUID>.xml

edit scale <name> <x> <y> <z> – Change the scale of a named prim

force update – Force the update of all objects on clients

rotate scene <degrees> [centerX, centerY] – Rotates all scene objects around centerX, centerY (default 128, 128) (please back up your region before using)

scale scene <factor> – Scales the scene objects (please back up your region before using)

show object id [–full] <UUID-or-localID> – Show details of a scene object with the given UUID or localID

show object name [–full] [–regex] <name> – Show details of scene objects with the given name.

show object pos [–full] <start-coord> to <end-coord> – Show details of scene objects within the given area.

show part id <UUID-or-localID> – Show details of a scene object part with the given UUID or localID

show part name [–regex] <name> – Show details of scene object parts with the given name.

show part pos <start-coord> to <end-coord> – Show details of scene object parts within the given area.

translate scene xOffset yOffset zOffset – translates the scene objects (please back up your region before using)

Regions
create region [“region name”] <region_file.ini> – Create a new region.

delete-region <name> – Delete a region from disk

export-map [<path>] – Save an image of the world map

generate map – Generates and stores a new maptile.

physics get [<param>|ALL] – Get physics parameter from currently selected region

physics list – List settable physics parameters

physics set <param> [<value>|TRUE|FALSE] [localID|ALL] – Set physics parameter from currently selected region

region get – Show control information for the currently selected region (host name, max physical prim size, etc).

region restart abort [<message>] – Abort a region restart

region restart bluebox <message> <delta seconds>+ – Schedule a region restart

region restart notice <message> <delta seconds>+ – Schedule a region restart

region set – Set control information for the currently selected region.

remove-region <name> – Remove a region from this simulator

restart – Restart the currently selected region(s) in this instance

set terrain heights <corner> <min> <max> [<x>] [<y>] – Sets the terrain texture heights on corner #<corner> to <min>/<max>, if <x> or <y> are specified, it will only set it on regions with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate. Corner # SW = 0, NW = 1, SE = 2, NE = 3, all corners = -1.

set terrain texture <number> <uuid> [<x>] [<y>] – Sets the terrain <number> to <uuid>, if <x> or <y> are specified, it will only set it on regions with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate.

set water height <height> [<x>] [<y>] – Sets the water height in meters. If <x> and <y> are specified, it will only set it on regions with a matching coordinate. Specify -1 in <x> or <y> to wildcard that coordinate.

show neighbours – Shows the local region neighbours

show ratings – Show rating data

show region – Show control information for the currently selected region (host name, max physical prim size, etc).

show regions – Show region data

show regionsinview – Shows regions that can be seen from a region

show scene – Show live information for the currently selected scene (fps, prims, etc.).

sun current_time [<value>] – time in seconds of the simulator

sun day_length [<value>] – number of hours to a day

sun day_night_offset [<value>] – induces a horizon shift

sun day_time_sun_hour_scale [<value>] – scales day light vs nite hours to change day/night ratio

sun help – list parameters that can be changed

sun list – list parameters that can be changed

sun update_interval [<value>] – how often to update the sun’s position in frames

sun year_length [<value>] – number of days to a year

wind base wind_update_rate [<value>] – Get or set the wind update rate.

wind ConfigurableWind avgDirection [<value>] – average wind direction in degrees

wind ConfigurableWind avgStrength [<value>] – average wind strength

wind ConfigurableWind rateChange [<value>] – rate of change

wind ConfigurableWind varDirection [<value>] – allowable variance in wind direction in +/- degrees

wind ConfigurableWind varStrength [<value>] – allowable variance in wind strength

wind SimpleRandomWind strength [<value>] – wind strength

Scripts
scripts resume [<script-item-uuid>+] – Resumes all suspended scripts

scripts show [<script-item-uuid>+] – Show script information

scripts start [<script-item-uuid>+] – Starts all stopped scripts

scripts stop [<script-item-uuid>+] – Stops all running scripts

scripts suspend [<script-item-uuid>+] – Suspends all running scripts

show script sensors – Show script sensors information

show script timers – Show script sensors information

show scripts [<script-item-uuid>+] – Show script information

xengine status – Show status information

Terrain
terrain load – Loads a terrain from a specified file.

terrain load-tile – Loads a terrain from a section of a larger file.

terrain save – Saves the current heightmap to a specified file.

terrain save-tile – Saves the current heightmap to the larger file.

terrain fill – Fills the current heightmap with a specified value.

terrain elevate – Raises the current heightmap by the specified amount.

terrain lower – Lowers the current heightmap by the specified amount.

terrain multiply – Multiplies the heightmap by the value specified.

terrain bake – Saves the current terrain into the regions baked map.

terrain revert – Loads the baked map terrain into the regions heightmap.

terrain newbrushes – Enables experimental brushes which replace the standard terrain brushes. WARNING: This is a debug setting and may be removed at any time.

terrain show – Shows terrain height at a given co-ordinate.

terrain stats – Shows some information about the regions heightmap for debugging purposes.

terrain effect – Runs a specified plugin effect

terrain flip – Flips the current terrain about the X or Y axis

terrain rescale – Rescales the current terrain to fit between the given min and max heights

terrain min – Sets the minimum terrain height to the specified value.

terrain max – Sets the maximum terrain height to the specified value.

Tree
tree active – Change activity state for the trees module

tree freeze – Freeze/Unfreeze activity for a defined copse

tree load – Load a copse definition from an xml file

tree plant – Start the planting on a copse

tree rate – Reset the tree update rate (mSec)

tree reload – Reload copse definitions from the in-scene trees

tree remove – Remove a copse definition and all its in-scene trees

tree statistics – Log statistics about the trees

Users
alert <message> – Send an alert to everyone

alert-user <first> <last> <message> – Send an alert to a user

appearance find <uuid-or-start-of-uuid> – Find out which avatar uses the given asset as a baked texture, if any.

appearance rebake <Vorname> <Nachname> – Send a request to the user’s viewer for it to rebake and reupload its appearance textures.

appearance send [<Vorname> <Nachname>] – Send appearance data for each avatar in the simulator to other viewers.

appearance show [<Vorname> <Nachname>] – Show appearance information for avatars.

attachments show [<Vorname> <Nachname>] – Show attachment information for avatars in this simulator.

bypass permissions <true / false> – Bypass permission checks

force permissions <true / false> – Force permissions on or off

kick user <first> <last> [–force] [message] – Kick a user off the simulator

login disable – Disable simulator logins

login enable – Enable simulator logins

login status – Show login status

reset user cache – reset user cache to allow changed settings to be applied

show animations [<Vorname> <Nachname>] – Show animation information for avatars in this simulator.

show appearance [<Vorname> <Nachname>] – Synonym for ‘appearance show’

show name <uuid> – Show the bindings between a single user UUID and a user name

show names – Show the bindings between user UUIDs and user names

show users [full] – Show user data for users currently on the region

sit user name [–regex] <Vorname> <Nachname> – Sit the named user on an unoccupied object with a sit target.

stand user name [–regex] <Vorname> <Nachname> – Stand the named user.

teleport user <Vorname> <Nachname> <destination> – Teleport a user in this simulator to the given destination

wearables check <Vorname> <Nachname> – Check that the wearables of a given avatar in the scene are valid.

wearables show [<Vorname> <Nachname>] – Show information about wearables for avatars.

vivox
vivox debug <on>|<off> – Set vivox debugging

Windlight
windlight load – Load windlight profile from the database and broadcast

windlight enable – Enable the windlight plugin

windlight disable – Disable the windlight plugin

Robust
Assets
delete asset <ID> – Delete asset from database dump asset <ID> – Dump asset to a file show asset <ID> – Show asset information

Comms
show http-handlers – Show all registered http handlers

Debug
debug comms set serialosdreq true|false – Set comms parameters. For debug purposes.

debug comms status – Show current debug comms parameters.

debug http <in|out|all> [<level>] – Turn on http request logging.

debug jobengine <start|stop|status|log> – Start, stop, get status or set logging level of the job engine.

debug threadpool level 0..3 – Turn on logging of activity in the main thread pool.

debug threadpool set worker|iocp min|max <n> – Set threadpool parameters. For debug purposes.

debug threadpool status – Show current debug threadpool parameters.

force gc – Manually invoke runtime garbage collection. For debugging purposes

show threadpool calls complete – Show details about threadpool calls that have been completed.

threads abort <thread-id> – Abort a managed thread. Use “show threads” to find possible threads.

fs
delete bakes <ID> – Delete agent’s baked textures from server

General
command-script <script> – Run a command script from file

config get [<section>] [<key>] – Synonym for config show

config save <path> – Save current configuration to a file at the given path

config set <section> <key> <value> – Set a config option. In most cases this is not useful since changed parameters are not dynamically reloaded. Neither do changed parameters persist – you will have to change a config file manually and restart.

config show [<section>] [<key>] – Show config information

get log level – Get the current console logging level

quit – Quit the application

set log level <level> – Set the console logging level for this session.

show checks – Show checks configured for this server

show grid size – Show the current grid size (excluding hyperlink references)

show info – Show general information about the server

show stats [list|all|(<category>[.<container>])+ – Alias for ‘stats show’ command

show threads – Show thread status

show uptime – Show server uptime

show version – Show server version

shutdown – Quit the application

stats record start|stop – Control whether stats are being regularly recorded to a separate file.

stats save <path> – Save stats snapshot to a file. If the file already exists, then the report is appended.

stats show [list|all|(<category>[.<container>])+ – Show statistical information for this server

threads show – Show thread status. Synonym for “show threads”

Hypergrid
link-mapping [<x> <y>] – Set local coordinate to map HG regions to

link-region <Xloc> <Yloc> <ServerURI> [<RemoteRegionName>] – Link a HyperGrid Region. Examples for <ServerURI>: http://grid.net:8002/ or http://example.org/path/foo.php

show hyperlinks – List the HG regions

unlink-region <local name> – Unlink a hypergrid region

Plugin
plugin add “plugin index” – Install plugin from repository. plugin disable “plugin index” – Disable a plugin plugin enable “plugin index” – Enable the selected plugin plugin plugin info “plugin index” – Show detailed information for plugin plugin list available – List available plugins plugin list installed – List install plugins plugin remove “plugin index” – Remove plugin from repository plugin update “plugin index” – Update the plugin plugin updates – List availble updates

Regions
deregister region id <region-id>+ – Deregister a region manually. set region flags <Region name> <flags> – Set database flags for region show region at <x-coord> <y-coord> – Show details on a region at the given co-ordinate. show region name <Region name> – Show details on a region show regions – Show details on all regions

Repository
repo add “url” – Add repository repo disable”[url | index]” – Disable registered repository repo enable “[url | index]” – Enable registered repository repo list – List registered repositories repo refresh “url” – Sync with a registered repository repo remove “[url | index]” – Remove repository from registry

Users
create user – creates a new user and password, and server prompts for all data

login level <level> – Set the minimum user level to log in

login reset – Reset the login level to allow all users

login text <text> – Set the text users will see on login

reset user email [<first> [<last> [<email>]]] – Reset a user email address

reset user password [<first> [<last> [<password>]]] – Reset a user password

set user level [<first> [<last> [<level>]]] – Set user level. If >= 200 and ‘allow_grid_gods = true’ in OpenSim.ini, this account will be treated as god-moded. It will also affect the ‘login level’ command.

show account <first> <last> – Show account details for the given user

show grid user <ID> – Show grid user entry or entries that match or start with the given ID. This will normally be a UUID.

show grid users online – Show number of grid users registered as online.

<< Konfigurationsdateien

