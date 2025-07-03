# User Dave Squier : 1234
opensimtar=opensim-0.9.1.1.tar.gz
firestormtar=Phoenix_FirestormOS-Release_x86_64_6.4.13.63251.tar.xz

function setup(){
tar xfvz opensim-0.9.1.1.tar.gz
cd opensim-0.9.1.1
mv bin/config-include/GridCommon.ini.example bin/config-include/GridCommon.ini
mv bin/config-include/StandaloneCommon.ini.example bin/config-include/StandaloneCommon.ini
mv bin/Regions/Regions.ini.example bin/Regions/Regions.ini
rm ./bin/Regions/*
cp ../Luminal.ini ./bin/Regions/

cat opensim-0.9.1.1/bin/OpenSim.ini| sed 's/; GenerateMaptiles = true/GenerateMaptiles = true/' > opensim-0.9.1.1/bin/OpenSim.ini
MapImageModule = "MapImageModule"
;TextureOnMapTile = true
TexturePrims = true

echo "INSTALLED $opensimtar" > ../../.installed
}

function downloader(){
https://www.firestormviewer.org/linux-for-open-simulator/
wget -c https://downloads.firestormviewer.org/linux/Phoenix_FirestormOS-Release_x86_64_6.4.13.63251.tar.xz

http://opensimulator.org/wiki/Download
wget -c http://opensimulator.org/dist/opensim-0.9.1.1.tar.gz

}
function runsimulator(){
cd opensim-0.9.1.1
cd bin
./opensim.sh
cd ../..
}

if [ -e $opensimtar ]; then echo "Tars found"; fi
if [ -e .installed ]; then runsimulator; else exit 1;fi

