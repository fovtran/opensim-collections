using System;
using System.Reflection;
using log4net;
using Mono.Addins;
using Nini.Config;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;
 
[assembly: Addin("BareBonesNonSharedModule", "0.1")]
[assembly: AddinDependency("OpenSim", "0.5")]
 
namespace OpenSim.Region.OptionalModules.Example.BareBonesNonShared
{
    /// <summary>
    /// Simplest possible example of a non-shared region module.
    /// </summary>
    /// <remarks>
    /// This module is the simplest possible example of a non-shared region module (a module where each scene/region
    /// in the simulator has its own copy).
    /// When the module is enabled it will print messages when it receives certain events to the screen and the log
    /// file.
    /// </remarks>
    [Extension(Path = "/OpenSim/RegionModules", NodeName = "RegionModule", Id = "BareBonesNonSharedModule")]
    public class BareBonesNonSharedModule : INonSharedRegionModule
    {
        private static readonly ILog m_log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
         public string Name { get { return "Bare Bones Non Shared Module"; } }        
        public Type ReplaceableInterface { get { return null; } }
 
        public void Initialise(IConfigSource source) { m_log.DebugFormat("[BARE BONES]: INITIALIZED MODULE"); }
        public void Close() { m_log.DebugFormat("[BARE BONES]: CLOSED MODULE"); }
        public void AddRegion(Scene scene) { m_log.DebugFormat("[BARE BONES]: REGION {0} ADDED", scene.RegionInfo.RegionName); }
        public void RemoveRegion(Scene scene) { m_log.DebugFormat("[BARE BONES]: REGION {0} REMOVED", scene.RegionInfo.RegionName); }        
        public void RegionLoaded(Scene scene) { m_log.DebugFormat("[BARE BONES]: REGION {0} LOADED", scene.RegionInfo.RegionName); }                
    }
}