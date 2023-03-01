#!/usr/bin/env python

# Reeeeallly simple 4:1 un-Bayer for the Chang'e
# mosaicked PNGs posted here:
# http://planetary.s3.amazonaws.com/data/change3/tcam.html
# See also:
# http://www.planetary.org/blogs/emily-lakdawalla/2016/01281656-fun-with-a-new-data-set-change.html

# Usage: python demosaic.py TCAM-[...].png x.png

# This is alpha quality. I've tested it on one image
# so far. Released into the public domain by Charlie Loyd,
# 2016-01-30 (UTC, obvs).

import skimage
from skimage import io
from skimage.transform import resize
import numpy as np
from sys import argv

# We'll use floats as an intermediate type, and
# skimage likes them always in the range -1..1:
def byte_to_unit(n):
  return n/np.iinfo(np.uint8).max
  
def unit_to_byte(n):
  return np.clip(
    n * np.iinfo(np.uint8).max,
    0,
    np.iinfo(np.uint8).max
  ).astype(np.uint8)

src = io.imread(argv[1])

dst = np.dstack([
  np.zeros_like(src),
  np.zeros_like(src),
  np.zeros_like(src)
])

# There's probably a *way* neater way to do this, with
# clearer arithmetic and without explicit iteration:

for x in range(src.shape[0]):
  for y in range(src.shape[1]):
    
    if (x % 2 != y % 2): # green on the diagonals
      dst[x, y, 1] = src[x, y]/2 # we lose a bit here!
      
    elif (x % 2 == 1 and y % 2 == 1): # red
      dst[x, y, 0] = src[x, y]
      
    else: # blue; (x % 2 == 0 and y % 2 == 0)
      dst[x, y, 2] = src[x, y]

dst = byte_to_unit(dst.astype(np.float32))

dst = resize(dst, (src.shape[0]/2, src.shape[1]/2))
dst *= 4
dst[:,:,2] *= 1.75 # Totally arbitrary but seems to fix the blue!
dst = unit_to_byte(dst)

io.imsave(argv[2], dst)