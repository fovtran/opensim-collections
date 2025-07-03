### Console Commands
alert
alert [First] [Last] [Message]
Send an alert to a user. Case sensitive.

alert general
alert general [Message]
Send an alert to all users.

backup
backup
Trigger a simulator backup.

change-region
change-region [region name]
Subsequent commands apply only to the specified region.

change-region root
change-region root
Exits the region and returns to ‘root.

clear-assets
clear-assets
Forcibly clears asset cache, probably leaving sim unstable. Use with caution.

create user
create user [first] [last] [passw] [RegionX] [RegionY]

Creates a new user and password.

create-region
create-region [name] [filename]
Creates a new region.

help
help
Brings up a help screen of commands.

load-oar
load-oar [filename.oar.tar.gz]
Load an OpenSimulator archive. This entirely replaces the current region. Default filename is scene_oar.tar.gz. See OpenSim Archives for more details.

load-xml2
load-xml2 [filename.xml]
Optional parameters not supported for XML2 format as of 1-Jul-2008.

save-xml2
save-xml2 [filename.xml]
Save prims to XML (Format 2 – rearrangement of some nodes, to make loading/saving easier).