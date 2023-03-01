# El formato COLLADA es similar a lo siguiente

``` 
<?xml version="1.0"?>
<COLLADA>
	<asset>
		<up_axis>Z_UP</up_axis>
	</asset>
	<library_materials>
		<material id="Color">
		</material>
	</library_materials>

	<library_geometries>
		<geometry id="geom-box" name="box01">
			<mesh>
				<source id="positions">
					<float_array id="positions-array" count="24">
					</float_array>

				</source>
				<source id="normals">
					<float_array id="normals-array" count="18">
					</float_array>
				</source>

				<vertices>
				</vertices>

				<triangles name="sample_tris" count="24" material="Color">
				</triangles>				
			</mesh>
		</geometry>
	</library_geometries>

	<library_visual_scenes>
		<visual_scene id="myscene">
			<node id="node-Box01" name="box01">
				<instance_geometry url="#geom-box">
				</instance_geometry>
			</node>
		</visual_scene>
	</library_visual_scenes>

	<scene>
		<instance_visual_scene url="#MaxScene"/>
	</scene>

</COLLADA>
