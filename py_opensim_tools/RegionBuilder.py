import os,sys
import re
import math
import configparser

basedir = "d:\\reolder"
diva_dir = "diva-r09000"
os_dir = os.path.join(basedir, diva_dir)
regions os.path.join(os_dir, 'bin\\Regions')

class Region:
    def __init__(self):
        self.Name = None
        self.InternalAddress = None
        self.InternalPort = None
        self.AllowAlternatePorts = False
        self.ExternalHostName = "SYSTEMIP"
        self.ResolveAddress = False
        self.RegionUUID = None
        self.MaptileStaticUUID = None
        self.Terrain = None
        self.Location = ""
        self.SizeX = 512
        self.SizeY = 512
        self.MaxAgents = 100
        self.MaxPrims = 15000
        self.ClampPrimSize = False
        self.PhysicalPrimMax = 128
        self.NonphysicalPrimMax = 256
        self.opensim_dir = regions_path
        self.cur_dir = os.listdir(self.opensim_dir)
                
class RegionIO:
    def __init__(self,p):
        self.regions = None
        self.region_data = {}
        self.region_files = [r for r in self.cur_dir if r.endswith('.ini')]

    def ReadRegions(self):
        for region_name in self.region_files:
            reg = os.path.join(self.opensim_dir, region_name)
            config = configparser.ConfigParser()
            config.read(reg)
            self.regions = config.sections()
            self.region_data[self.regions[0]] = config.keys()

    def ListRegions(self):
        pass
    def NewRegion(self):
        pass

class UI:
    def __init__(self):
        pass

if __name__ == "__main__":
    print ("Open Simulator Region Builder")            
    regions = RegionIO(os_dir)
    regions.ReadRegions()
    print(regions.region_data)