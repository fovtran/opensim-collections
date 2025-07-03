http://dalaifelinto.com/geometry-nodes/addons/rigging/rigify/basics.html#basic-rig-generation
http://dalaifelinto.com/geometry-nodes/addons/rigging/rigify/bone_positioning.html#fingers-bones
http://dalaifelinto.com/geometry-nodes/addons/rigging/rigify/bone_positioning.html#face-bones


UV mapping
Anyone who has used the Build Tools inside of Second Life already understands UV mapping, but perhaps under different terminology. UV mapping is simply setting texture repeats(U and V) and offsets. If you look closely at the Build Tools Texture tab you'll see that U and V are used for the texture offset values already. Lean on that familiarity and this concept will come more easily.

General UV mapping techniques
Standard UV mapping
The most common UV map technique divides the mesh surface into neatly flattened sections. Most 3D modeling software packages have this functionality built in.

UV mapping this way has advantages and disadvantages:

The shapes created usingthis UV mapping technique makes it easier to visualize how the texture will apply inworld, which makes modifying and drawing on the texture easier.
Most 3D modeling software packages can be used to generate beautiful textures using this mapping technique(in conjunction with Projection mapping, scene lighting, etc.).
The disadvantages become apparent with larger or very complex objects. One simply runs out of pixels(or texture space) if trying to flatten a complex object onto one UV map. Instead, large objects often need a seamless repeatable texture.
Projection UV mapping
Projection UV mapping is much like applying textures to a prim object inworld, the goal of projection UV mapping is to scale, rotate, and offset a diffuse texture so the object wears it perfectly.

The advantage of projection UV mapping is versatility. A house UV mapped this way can wear any number of standard wall, roof, or trim textures.
The texture can be repeated and offset.
The texture can be animated.
Disadvantages:

Potential for texture size overuse inworld.
Models uploaded with projection UV maps can not take advantage of modeling software's texture baking capability.
Baking textures
An advanced feature of most modeling software packages uses both the Standard UV map and the projection maps to render an image. This is sometimes referred to as "baking" a texture. The goal is to use all the texture information stored in the Projection maps to create an image that fits the Standard UV map. This render can be influenced by any lighting or other objects in the scene.



