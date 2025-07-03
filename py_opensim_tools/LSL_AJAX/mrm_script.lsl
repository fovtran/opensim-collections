//MRM:C#
using OpenMetaverse;
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      public int chat_channel = 123;
      
      public override void Start()
        {
           
            Host.Object.Say("Starting up script...(MRM)");
            World.OnChat += World_OnChat;
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "MRM : Dialog";
        }

      void World_OnChat(IWorld sender, ChatEventArgs e)
      {
          if(e.Channel == chat_channel) { Host.Object.Say(e.Text); }
      }
        
      void OnTouched(IObject sender, TouchEventArgs e)
      {
          string[] buts = new string[] {"Hello","Hola","Hallo","Ni Hao"};
          Host.Object.Dialog(e.Avatar.GlobalID, "Choose your greeting",buts,chat_channel);
      }

      public override void Stop() { }
   }
}