Prim
A primitive ("prim" for short) is the basic building block (made up of polygons) of Second Life. Using SL's built-in object editor, just about anything can be modeled out of primitives.

A prim has a name, description, material, and a basic shape (box, sphere, cylinder, torus, etc) that can be resized and modified by changing its parameters (cut, hollow, twist, taper, shear, etc). Each prim has several sides which each have a color, opacity, and texture that can be rotated, repeated (UV), and offset. Optionally, a prim can have such features floating text, a particle system, light-emissive, or be flexible.

An object can be made by linking multiple primitives together, but a single prim is an object as well.

Each prim has an inventory that can contain items like scripts, objects, notecards, textures, or anything else in a user's inventory. All running scripts are contained within the prims of an object.

Despite the similarity in names, Second Life's primitives are not true primitives like you'd find in 3D modeler such as 3D Studio MAX or Maya, but are actually parametric models: simple 3D objects with variable property settings that give the appearance of primitives that can be deformed to a degree (but things like vertex manipulation or CSG subtraction can't be done to them).

There is an ongoing debate surrounding the question of supplementing parametric models with true meshes. At this time, meshes are supported as sculpted objects in Second Life.

Functions
Function	Description
llGetAlpha ²	Get prim transparency
llSetAlpha ²	Set prim transparency
llSetLinkAlpha ²	Sets transparency of another prim in linkset
llGetBoundingBox	Get prim bounding box.
llGetColor ²	Get prim color
llSetColor ²	Set prim color
llSetLinkColor ²	Sets color of another prim in linkset
llGetNumberOfPrims	Get total number of prims in linkset
llGetNumberOfSides¹²	Get prim sides
llGetObjectDesc	Get prim description
llGetObjectName	Get prim name
llGetObjectPermMask	Get object permissions
llGetObjectPrimCount	Returns the prim count for any specific object in a sim
llGetPrimitiveParams	Get nearly every prim attribute
llGetLinkPrimitiveParams	Gets prim attributes of another prim in linkset
llSetPrimitiveParams	Set nearly every prim attribute
llSetLinkPrimitiveParams	Sets prim attributes of another prim in linkset
llSetLinkPrimitiveParamsFast	Same as llSetLinkPrimitiveParams without script delays
llParticleSystem ¹	Configure prim particle emitter
llSetCameraAtOffset¹
llSetCameraEyeOffset¹	Changes the camera configuration of avatars that sit on the prim.
llGetMass	Gets the mass of the prim
llSetObjectDesc	Set prim description
llGetObjectMass	Gets the mass of the object specified by the key.
llSetObjectName	Set prim name
llSetObjectPermMask	Set object permissions
llGetPos	Get the position of a prim or linkset
llGetLocalPos	Get the position of a prim within a linkset relative to its root prim
llSetPos	Set the position of a prim or link set
llGetLocalRot	Get the position of a prim within a linkset relative to its root prim
llGetRot	Get the rotation of a prim or link set
llSetLocalRot	Set the rotation of a prim within a linkset relative to its root prim
llSetRot	Set the rotation of a prim or link set
llGetScale ²	Get prim scale
llSetScale ²	Set prim scale
llSitTarget¹	Set prim sit target
llSetSitText¹	Replace prim "Sit" text in pie menu
llSetStatus ³	Toggle various attributes of prim/object: phantom, physics, rotational limitations and die/return conditions.
llSetText ¹	Set floating text above prim
llGetTexture ²	Get prim texture
llSetTexture ²	Set prim texture
llSetLinkTexture ²	Sets texture of another prim in linkset
llSetTouchText¹	Replace prim "Touch" text in pie menu
llSetRemoteScriptAccessPin¹	Set prim remote script access pin
llSetClickAction	Set the action performed when a prim is clicked upon.
¹ These are not traditional prim functions in the sense that they cannot be set from the object editor, but their attributes survive regardless if a script is present in the object.
² Can apply to sides or prims.
³ Only phantom and physics can currently be set from the editor menu.

