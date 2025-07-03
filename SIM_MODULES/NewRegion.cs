using System;
using System.Collections.Generic;
using System.Reflection;
using log4net;
using Nini.Config;
using OpenMetaverse; 
using OpenSim.Framework;
using OpenSim.Region.Framework;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;

namespace HelloWorld
{
    public class HelloWorldModule : IRegionModuleBase
    {
		private static readonly ILog m_log = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
		List<Scene> m_scenes = new List<Scene>();
		Dictionary<Scene, List<SceneObjectGroup>> scene_prims = new Dictionary<Scene, List<SceneObjectGroup>>();
		 
		int counter = 0;
		bool positive = true;
		
	#region IRegionModule interface
	 
	public void Initialise(Scene scene, IConfigSource config) { m_log.Info("[HELLOWORLD] Initializing..."); m_scenes.Add(scene); }
	 
	public void PostInitialise()
	{
		m_scenes[0].EventManager.OnFrame += new EventManager.OnFrameDelegate(OnTick);
		foreach (Scene s in m_scenes)
			DoHelloWorld(s);
	}
	 
	public void Close() { }	 
	public string Name { get { return "Hello World Module"; } }
	public bool IsSharedModule { get { return true; } }

	#endregion
void DoHelloWorld(Scene scene)
{
    // We're going to write HELLO with prims 
    List<SceneObjectGroup> prims = new List<SceneObjectGroup>();
    // First prim: |
    Vector3 pos = new Vector3(120, 128, 30);
    SceneObjectGroup sog = new SceneObjectGroup(UUID.Zero, pos, PrimitiveBaseShape.CreateBox());
    sog.RootPart.Scale = new Vector3(0.3f, 0.3f, 2f);
    prims.Add(sog);
    // Add these to the managed objects
    scene_prims.Add(scene, prims);
    // Now place them visibly on the scene
    foreach (SceneObjectGroup sogr in prims) { scene.AddNewSceneObject(sogr, false); }
}

	void OnTick()
	{
		if (counter++ % 50 == 0)
		{
			foreach (KeyValuePair<Scene, List<SceneObjectGroup>> kvp in scene_prims)
			{
				foreach (SceneObjectGroup sog in kvp.Value)
				{
					if (positive)
						sog.AbsolutePosition += new Vector3(5, 5, 0);
					else
						sog.AbsolutePosition += new Vector3(-5, -5, 0);
					sog.ScheduleGroupForTerseUpdate();
				}
			}
			positive = !positive;
		}
	}
}
}