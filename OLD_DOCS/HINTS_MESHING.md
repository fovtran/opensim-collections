Collected Hints

Any 3D modelling software will work, as long as it can output models in COLLADA (.dae) format. Note: Second Life uses COLLADA 1.4.1. (see Second Life Wiki – Mesh Background Information
A “model” can have many separate “mesh” parts in it.
The maximum mesh asset size after compression is 8MB, roughly equivalent to a 256MB raw COLLADA file. An entire region can support up to 128MB of distinct mesh assets after compression, not including attachments.
A single convex hull is limited to 256 triangles.
Maximum number of vertices is limited to 65,536.
Scale limit is set to 64 meters.
Take care to create low polygon meshes (as few verts as possible).
Use no more than 8 face textures (8 materials assignments) on any mesh. These will import as “faces” in Second Life/OpenSim, which can be individually textured. You need to create a UV mapping for your model and its mesh parts which defines what part of the texture will go on which polygons of each mesh.
Avoid intersecting faces (unless intersections are intended).
Avoid duplicate vertices (unless you want to use the split modifier).
Avoid creating more than 21844 tris per texture face.
Avoid creating extremely small polygons (< 0.1 cm edge length).
Make sure the objects, materials, submaterials and textures in the meshes do not contain any spaces. (so not “Box 001” which will give the “Error: element is invalid”, but “Box001” or “Box_001”).
You can use any of the modelling tools while working on your model, but in the final form it should be saved before export as an Editable Poly.
Before you export your mesh, make sure that it doesn’t have any stray vertices or overlapping edges. These will either cause unexpected visual results in Second Life or worse, the mesh will fail to upload entirely.
For all meshes, make sure that the “Up Axis” is set to “Z-up”. If the axis isn’t set to Z-up, the mesh axis will be flipped on its side and/or rotated in Second Life/OpenSim.
Advice on Levels of Detail (LOD)… note the need for the bounding box to be identical in all models, and all LODs to have same number of textures. See http://wiki.secondlife.com/wiki/Mesh_and_LOD.
Textures can be provided for the usual diffuse image, a normal map (Bumpiness) and for specularity (shininess). PNG and TGA formats are allowed. PNG is to be preferred. Stick to x/y dimensions that are a power of 2 as on import textures are reduced to the nearest power of 2.

pip3.9 install pycollada

