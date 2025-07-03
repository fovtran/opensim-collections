### Details of Terrain Module Commands
terrain load
Loads a terrain from a specified file.

Parameters

filename (String)
The file you wish to load from, the file extension determines the loader to be used. Supported extensions include: .r32 (RAW32) .f32 (RAW32) .ter (Terragen) .raw (LL/SL RAW) .jpg (JPEG) .jpeg (JPEG) .bmp (BMP) .png (PNG) .gif (GIF) .tif (TIFF) .tiff (TIFF)

terrain load-tile
Loads a terrain from a section of a larger file.

Parameters

filename (String)
The file you wish to load from, the file extension determines the loader to be used. Supported extensions include: .r32 (RAW32) .f32 (RAW32) .ter (Terragen) .raw (LL/SL RAW) .jpg (JPEG) .jpeg (JPEG) .bmp (BMP) .png (PNG) .gif (GIF) .tif (TIFF) .tiff (TIFF)

file width (Integer)
The width of the file in tiles

file height (Integer)
The height of the file in tiles

minimum X tile (Integer)
The X region coordinate of the first section on the file

minimum Y tile (Integer)
The Y region coordinate of the first section on the file

terrain save
Saves the current heightmap to a specified file.

Parameters

filename (String)
The destination filename for your heightmap, the file extension determines the format to save in. Supported extensions include: .r32 (RAW32) .f32 (RAW32) .ter (Terragen) .raw (LL/SL RAW) .jpg (JPEG) .jpeg (JPEG) .bmp (BMP) .png (PNG) .gif (GIF) .tif (TIFF) .tiff (TIFF)

terrain fill
Fills the current heightmap with a specified value.

Parameters

value (Double)
The numeric value of the height you wish to set your region to.

terrain elevate
Raises the current heightmap by the specified amount.

Parameters

amount (Double)
terrain lower
Lowers the current heightmap by the specified amount.

Parameters

amount (Double)
The amount of height to remove from the terrain in meters.

terrain multiply
Multiplies the heightmap by the value specified.

Parameters

value (Double)
The value to multiply the heightmap by.

terrain bake
Saves the current terrain into the regions revert map.

terrain revert
Loads the revert map terrain into the regions heightmap.

terrain newbrushes
Enables experimental brushes which replace the standard terrain brushes. WARNING: This is a debug setting and may be removed at any time.

Parameters

Enabled? (Boolean)
true / false - Enable new brushes

terrain stats
Shows some information about the regions heightmap for debugging purposes.

terrain effect
Runs a specified plugin effect

Parameters

name (String)
The plugin effect you wish to run, or 'list' to see all plugins

terrain modify
Allows area-of-effect and tapering with standard heightmap manipulations.

General command usage:

terrain modify <operation> value [<mask>] [-taper=<value2>]
Parameters
value: base value to use in applying operation
mask:
-rec=x1,y1,dx[,dy] creates a rectangular mask based at x1,y1
-ell=x0,y0,rx[,ry] creates an elliptical mask centred at x0,y0
taper:
rectangular masks taper as pyramids
elliptical masks taper as cones

Terrain Manipulation (fill, min, max)

value represents target height (at centre of range)
value2 represents target height (at edges of range)
Terrain Movement (raise, lower, noise)

value represents a delta amount (at centre of range)
value2 represents a delta amount (at edges of range)
Terrain Smoothing (smooth)

The smoothing operation is somewhat different than the others, as it does not deal with elevation values, but rather with strength values (in the range of 0.01 to 0.99). The algorithm is simplistic in averaging the values around a point, and is implemented as follows:
The "strength" parameter specifies how much of the result is from the original value ("strength" * map[x,y]).
The "taper" parameter specifies how much of the remainder is from the first ring surrounding the point (1.0 - "strength") * "taper". There are 8 elements in the first ring.
The remaining contribution is made from the second ring surrounding the point. There are 16 elements in the second ring.
e.g.
terrain modify smooth 0.5 -taper=0.6
the original element will contribute 0.5 * map[x0,y0]
each element 1m from the point will contribute ((1-0.5)*0.6)/8 * map[x1,y1]
each element 2m from the point will contribute ((1-0.5)*0.4)/16 * map[x2,y2]
Notes:

The "taper" value may need to be exaggerated due to the integer math used in maps.
e.g. To create a 512x512 var island:
terrain modify min 30 -ell=256,256,240 -taper=-29
