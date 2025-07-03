docker run -d --name opensim -p 9000:9000 -p 9000:9000/udp soupbowl/opensimulator:latest
docker run -d --name opensim -p 9000:9000 -p 9000:9000/udp soupbowl/opensimulator:latest \
	-e GRID_NAME=Luminal \
	-e GRID_WELCOME=Hello \
	-e  REGION_NAME=Luminal \
	-e ESTATE_NAME=City \
	-e ESTATE_OWNER_NAME=diego \
	-e ESTATE_OWNER_PASSWORD=diego77 \
	-e DATABASE_ENGINE=sqlite \
	-e PHYSICS_ENGINE=basicphysics
