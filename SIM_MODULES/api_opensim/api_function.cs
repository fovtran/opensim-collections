using System;
using Nini.Config;
using OpenMetaverse;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;

namespace OpenSim.Region.ScriptEngine.Shared.Api
 {
     public class XXX_Api: MarshalByRefObject, IXXX_Api, IScriptApi
     {
        internal IScriptEngine m_ScriptEngine;
        internal SceneObjectPart m_host;
        internal uint m_localID;
        internal LLUUID m_itemID;
 
        public void Initialize(IScriptEngine ScriptEngine, SceneObjectPart host, uint localID, LLUUID itemID)
        {
            m_ScriptEngine = ScriptEngine;
            m_host = host;
            m_localID = localID;
            m_itemID = itemID;
        }
 
        public void myApiFunction() { }
     }
 }
