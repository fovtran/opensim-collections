#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from collada import *

mesh = Collada()


image = material.CImage("material_0_1_0-image", "./image1.png")
surface = material.Surface("material_0_1_0-image-surface", image)
sampler2d = material.Sampler2D("material_0_1_0-image-sampler", surface)
map = material.Map(sampler2d, "UVSET0")
effect1 = material.Effect("material_0_0-effect", [], "lambert", emission=(0.0, 0.0, 0.0, 1),\
                         ambient=(0.0, 0.0, 0.0, 1), diffuse=(0.890196, 0.882353, 0.870588, 1),\
                         transparent=(1, 1, 1, 1), transparency=1.0, double_sided=True)
effect2 = material.Effect("material_0_1_0-effect", [surface, sampler2d], "lambert", emission=(0.0, 0.0, 0.0, 1),\
                         ambient=(0.0, 0.0, 0.0, 1),  diffuse=map, transparent=map, transparency=0.0, double_sided=True)
mat1 = material.Material("material_0_0ID", "material_0_0", effect1)
mat2 = material.Material("material_0_1_0ID", "material_0_1_0", effect2)
mesh.effects.append(effect1)
mesh.effects.append(effect2)
mesh.materials.append(mat1)
mesh.materials.append(mat2)
mesh.images.append(image)

m1position = [0.0, 8.0, 8.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.0, 0.0, 8.0, 0.0, 0.2, 0.0, 8.0, 0.2, 8.0,
              0.0, 0.2, 0.0, 0.0, 0.2, 8.0, 8.0, 0.2, 8.0, 0.0, 0.2, 0.0, 8.0, 0.2, 8.0, 8.0]

m1normal = [-1.0, 0.0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, -1.0, 1.0, 0.0,
             0.0, 0.0254, 0.0, 0.0, -0.0254, -0.0, -0.0]

m1uv = [-314.96063, 314.96063, 0.0, 0.0, 0.0, 314.96063, -314.96063, 0.0, 7.874016, 314.96063, 7.874016,
         0.0, -7.874016, 0.0, -7.874016, 314.96063, 314.96063, 0.0, 1.0, 0.0, 0.0, 1.0, 314.96063, 314.96063,
         1.0, 1.0]

m1position_src = source.FloatSource("mesh1-geometry-position", np.array(m1position), ('X', 'Y', 'Z'))
m1normal_src = source.FloatSource("mesh1-geometry-normal", np.array(m1normal), ('X', 'Y', 'Z'))
m1uv_src = source.FloatSource("mesh1-geometry-uv", np.array(m1uv), ('S', 'T'))
geom = geometry.Geometry(mesh, "mesh1-geometry", "mesh1-geometry", [m1position_src, m1normal_src, m1uv_src])

input_list = source.InputList()
input_list.addInput(0, 'VERTEX', "#mesh1-geometry-position")
input_list.addInput(1, 'NORMAL', "#mesh1-geometry-normal")
input_list.addInput(2, 'TEXCOORD', "#mesh1-geometry-uv", set="0")

indices1 = np.array([0, 0, 0, 1, 0, 1, 2, 0, 2, 1, 0, 1, 0, 0, 0, 3, 0, 3, 1, 1, 1, 4, 1, 4, 2, 1, 2, 4, 2, 5, 0, 2,
            2, 2, 2, 1, 0, 3, 2, 5, 3, 6, 3, 3, 1, 5, 4, 7, 1, 4, 1, 3, 4, 2, 4, 1, 4, 1, 1, 1, 6, 1, 5, 0,
            2, 2, 4, 2, 5, 7, 2, 4, 5, 3, 6, 0, 3, 2, 7, 3, 7, 1, 4, 1, 5, 4, 7, 6, 4, 6, 5, 5, 8, 4, 5, 2,
            6, 5, 1, 4, 5, 2, 5, 5, 8, 7, 5, 11])

indices2 = np.array([6, 6, 1, 8, 6, 9, 9, 6, 10, 6, 7, 1, 9, 7, 10, 8, 7, 9, 10, 6, 12, 9, 6, 10, 8, 6, 9, 10, 7, 12,
            8, 7, 9, 9, 7, 10])

triset1 = geom.createTriangleSet(indices1, input_list, "material_0_0")
triset2 = geom.createTriangleSet(indices2, input_list, "material_0_1_0")
geom.primitives.append(triset1)
geom.primitives.append(triset2)
mesh.geometries.append(geom)

#xfov is missing
camera = camera.Camera()
#camera = camera.Camera("Camera-camera", fov=35.0, near=0.0254, far=25.4)
mesh.cameras.append(camera)

matnode1 = scene.MaterialNode("material_0_0", mat1, inputs=[])
matnode2 = scene.MaterialNode("material_0_1_0", mat2, inputs=[])
geomnode = scene.GeometryNode(geom, [matnode1, matnode2])
node = scene.Node("Model", children=[geomnode])
matrix = np.array([0.729411, -0.170033, 0.662607, 15.764557, 0.684076, 0.181301, -0.706520, -11.477403, 0.000000,
                   0.968617, 0.248558, 7.208134, 0.000000, 0.000000, 0.000000, 1.000000])
mtrans = scene.MatrixTransform(matrix)
#node2 = scene.Node("Camera", transforms=[mtrans])
#node3 = scene.CameraNode(camera)
# Need to handle camera node differently
myscene = scene.Scene("SketchUpScene", [node, node2, node3])
mesh.scenes.append(myscene)
mesh.scene = myscene

#mesh.write("new.dae")
# Chrome supports xml tag folding.
mesh.write("new.xml")