using System;
using Nini.Config;
using OpenMetaverse;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;

namespace OpenSim.Region.ScriptEngine.Shared.ScriptBase
 {
     public partial class ScriptBaseClass : MarshalByRefObject
     {
         public IXXX_Api m_XXX_Functions;
 
         public void ApiTypeXXX(IScriptApi api)
         {
             if(!(api is IXXX_Api))
                 return;
 
             m_XXX_Functions = (IXXX_Api)api;
         } 
         public void myApiFunction() { m_XXX_Functions.myApiFunction(); }
     }
 }
