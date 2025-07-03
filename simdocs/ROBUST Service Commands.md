### ROBUST Service Commands
These can also be accessed on the simulator command console itself in standalone mode.

Asset Service
delete asset <ID> - Delete an asset from the database. Doesn't appear to be implemented.
dump asset <ID> - Dump an asset to the filesystem. OpenSimulator 0.7.3 onwards.
show digest <ID> - Show summary information about an asset. From OpenSimulator 0.7.3 onwards this will be renamed to "show asset"
Grid Service
set region flags <Region name> <flags> - Set database flags for region
show region <Region name> - Show the details of a given region. This command is renamed to "show region name" in development versions of OpenSimulator.
The following commands currently only exist in development versions of OpenSimulator (post 0.7.3.1). These are currently found in the "Regions" help section.

deregister region id <Region UUID> - Deregister a region manually. This can be helpful if a region was not properly removed due to bad simulator shutdown and the simulator has not since been restarted or its region configuration has been changed.
show region at <x-coord> <y-coord> - Show details on a region at the given co-ordinate.
show region name <Region name> - Show details on a region
show regions - Show details on all regions. In standalone mode this version of the command is not currently available - the simulator version of "show regions" is used instead, which shows similar information.
User Service
create user [first] [last] [passw] [Email] [Primary UUID] [Model} - creates a new user
or just: create user - and server prompts for all data
If UUID is nul or whitespace a UUID will be generated for you.
Model is the "first lastname" of another user, that user's outfit will be cloned to the new user.
reset user password[<firstname> [<lastname> [<password>]]] - This command sets a new password for a user and directly updates the database. It does not reset the password to a default or temporary value, as the term might suggest.
show account <firstname> <lastname> - show account details for the given user name (0.7.2-dev)
Login Service
login level <value> - Set the miminim userlevel allowed to login (see User Level).
login reset - reset the login level to its default value.
login text <text to print during the login>
set user level <firstname> <lastname> <level> - Set UserLevel for the user, which determines whether a user has a god account or can login at all (0.7.2-dev) (see User Level).
