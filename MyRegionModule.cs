using System;
using Nini.Config;
using OpenMetaverse;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;

namespace ModSendCommandExample
{
  public class MyRegionModule : IRegionModuleBase
  {
    Scene m_scene;
    IScriptModuleComms m_commsMod;

    public string Name { get { return "MyRegionModule"; } }
    public bool IsSharedModule { get { return false; } }
    public void Close() {}

    public void Initialise(Scene scene, IConfigSource source)
    {
       m_scene = scene;
    }

    public void PostInitialise()
    {
      m_commsMod
        = m_scene.RequestModuleInterface<IScriptModuleComms>();
      m_commsMod.OnScriptCommand += ProcessScriptCommand;
    }

    void ProcessScriptCommand(
      UUID scriptId,
      string reqId, string module, string input, string k)
    {
      if ("MYMOD" != module)
        return;

      string[] tokens
          = input.Split(
              new char[] { '|' }, StringSplitOptions.None);

      string command = tokens[0];
      switch (command)
      {
        case "Greet":
          string name = tokens[1];
          m_commsMod.DispatchReply(scriptId, 1, "Hello " + name, "");
          break;
      }
    }
  }
}