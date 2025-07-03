//MRM:C#
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
    class MiniModule : MRMBase
    { 
        public override void Start()
        {
            Host.Object.Say("Starting up script...(MRM)");
            World.OnChat += World_OnChat;
            Host.Object.Say("Subscribed to World.OnChat..");
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "MRM : listen for Chat on non-0 Channels";
        }

        void World_OnChat(IWorld sender, ChatEventArgs e)
        {
            if (e.Sender is IAvatar && e.Channel == 9299)
            {
                Host.Object.Say("Rcvd msg on Channel " + e.Channel + " from " + e.Sender.GlobalID + " message is "+ e.Text);
            }
            else if(e.Sender is IObject && e.Channel == 9299)
            {
                Host.Object.Say("Rcvd msg on Channel " + e.Channel + " from and Object called " +e.Sender.GlobalID + " message is "+ e.Text);
            }
        }

        void OnTouched(IObject sender, TouchEventArgs e)
        {
            Host.Object.Say("Say something on a Channel other then 0 ( default ) i.e. /1 Hello ");
        }

        public override void Stop() { }
    }
}