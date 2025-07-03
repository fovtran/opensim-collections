regions Fields
uuid
The region's unique identifier

regionHandle
The absolute address of the origin coordinates, specified in metres, of the region calculated from LocX and LocY as
(LocX*256*65536)+(LocY*256).

regionName
The region's name as it appears on maps - not necesarily unique

regionRecvKey
The key used by the region server to verify authenticity of communications from other regions

regionSendKey
The key used by the region server when verifying its identity in communications with other regions

regionSecret
more detail req'd

regionDataURI
more detail req'd

serverIP
IP address of region server

serverPort
connection port for a specific region(this can be but need not be the same as http, each region should have its own port)

serverURI
http representation of serverIP and main http port

locX
X coordinate of region on the grid in absolute meters locX/256 is equal to coordinate in Regions.ini

locY
Y coordinate of region on the grid in absolute meters locY/256 is equal to coordinate in Regions.ini

locZ
Z coordinate of region on the grid *grinz*

eastOverrideHandle
more detail req'd

westOverrideHandle
more detail req'd

southOverrideHandle

more detail req'd

northOverrideHandle
more detail req'd

regionAssetURI
The URL and port number of the Asset Server for the grid

regionAssetRecvKey
Key used to verify the authenticity of communications received from the asset server

regionAssetSendKey
Key used to verify the authenticity of communications sent to the asset server

regionUserURI
The URL and port number of the User Server for the grid

regionUserRecvKey
Key used to verify the authenticity of communications received from the user server

regionUserSendKey
Key used to verify the authenticity of communications sent to the user server

regionMapTexture
Texture for the map as displayed in the client minimap

serverHttpPort
Port the region will answer on for HTTP requests

serverRemotingPort
more detail req'd

owner_uuid
UUID of the avatar/account which owns the region

originUUID
more detail req'd, currently seems to contain the current UUID of the region.

access
PG=13 Region is set to PG
Moderate=21 Region is set to Moderate
Adult=42 Region is set to Adult

ScopeID
more detail req'd

sizeX
X size of region (in m)

sizeY
Y size of region (in m)

flags
DefaultRegion=1 Default region for new avatars. Region is randomly selected if multiple regions have fallback flag set.
FallbackRegion=2 Regions we redirect to when the destination is down
RegionOnline=4 Set when a region comes online, unset when it unregisters and DeleteOnUnregister is false
NoDirectLogin=8 Region unavailable for direct logins (by name)
Persistent=16 Don't remove on unregister
LockedOut=32 Don't allow registration
NoMove=64 Don't allow moving this region
Reservation=128 This is an inactive reservation
Authenticate=256 Require authentication
Hyperlink=512 Record represents a HG link
DefaultHGRegion=1024 Record represents a default region for hypergrid teleports only.

last_seen
more detail req'd

PrincipalID
more detail req'd

Token
more detail req'd

### regions Table Structure
## The structure of the regions table is as follows:

Field	Type	Null	Key	Default	Extra
uuid	varchar(36)	NO	PRI	NULL	 
regionHandle	bigint(20) unsigned	NO	MUL	NULL	
regionName	varchar(32)	YES	MUL	NULL	
regionRecvKey	varchar(128)	YES		NULL	
regionSendKey	varchar(128)	YES		NULL	
regionSecret	varchar(128)	YES		NULL	
regionDataURI	varchar(255)	YES		NULL	
serverIP	varchar(64)	YES		NULL	
serverPort	int(10) unsigned	YES		NULL	
serverURI	varchar(255)	YES		NULL	
locX	int(10) unsigned	YES		NULL	
locY	int(10) unsigned	YES		NULL	
locZ	int(10) unsigned	YES		NULL	
eastOverrideHandle	bigint(20) unsigned	YES	MUL	NULL	
westOverrideHandle	bigint(20) unsigned	YES		NULL	
southOverrideHandle	bigint(20) unsigned	YES		NULL	
northOverrideHandle	bigint(20) unsigned	YES		NULL	
regionAssetURI	varchar(255)	YES		NULL	
regionAssetRecvKey	varchar(128)	YES	PRI	NULL	
regionAssetSendKey	varchar(128)	YES	PRI	NULL	
regionUserURI	varchar(255)	YES		NULL	
regionUserRecvKey	varchar(128)	YES		NULL	
regionUserSendKey	varchar(128)	YES		NULL	
regionMapTexture	varchar(36)	YES		NULL	
serverHttpPort	int(10)	YES		NULL	
serverRemotingPort	int(10)	YES		NULL	
owner_uuid	varchar(36)	NO		00000000-0000-0000-0000-000000000000	
originUUID	varchar(36)	YES		NULL	
access	int(10) unsigned	YES		1	
ScopeID	char(36)	NO		00000000-0000-0000-0000-000000000000	
sizeX	int(11)	NO		0	
sizeY	int(11)	NO		0	
flags	int(11)	NO		0	
last_seen	int(11)	NO		0	
PrincipalID	char(36)	NO		00000000-0000-0000-0000-000000000000	
Token	varchar(255)	NO		None	
parcelMapTexture	varchar(36)	YES		NULL