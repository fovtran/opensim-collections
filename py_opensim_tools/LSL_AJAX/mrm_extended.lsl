//MRM:C#
using System.Timers;
using OpenMetaverse;
using OpenSim.Region.OptionalModules.Scripting.Minimodule;

namespace OpenSim{
   class MiniModule : MRMBase
   {
        Timer repeater = new Timer();
        string avs_in_region;
        private Vector3 obj_pos;

        void GetUsers(object source, ElapsedEventArgs e)
        {
            //List the users, currently present on this Sim..
            avs_in_region = "";
            float av_dist = 0.0f;
            IAvatar[] avs = World.Avatars;
            for (int i = 0; i < avs.Length; i++)
            {
               if(avs[i].IsChildAgent) // the avatar is not in the current Region, but on a Neighbour Region
               {
                  avs_in_region += "(C:) ";
               }
               avs_in_region += avs[i].Name;
               avs_in_region += " " + avs[i].WorldPosition;
               av_dist = Vector3.Distance(obj_pos,avs[i].WorldPosition);
               avs_in_region += "  Distance : " + av_dist +"\n"; 
            }
            Host.Object.Text = avs_in_region;
            if(avs.Length == 0)
            {
               //Nobody here, so we can suspend the timer..
               repeater.Enabled = false;
               Host.Object.Text = "MRM : No Avatars present. Offline.";
            }           
        }
       
        void Repeat(int interval)
        {    
            //Activate the Timer
            repeater.Interval = interval;
            repeater.Elapsed += new ElapsedEventHandler(GetUsers);             
            repeater.AutoReset = true;
            repeater.Enabled = true;
        }
        
        public override void Start()
        {
            Host.Object.Say("Starting up script...(MRM)");
            World.OnNewUser += OnUser;  
            Host.Object.Text = "MRM : Execute Task every nn Seconds";
            obj_pos = Host.Object.WorldPosition;
            Repeat(10000);
        }

        public void OnUser(IWorld world, NewUserEventArgs e) 
        {
           //Someone entered the Simulator, if the Timer was suspended, reactivate...
           if(!repeater.Enabled)
           {
                  repeater.Enabled = true;
           }
        }
  
        public override void Stop()
        {
            repeater.Enabled = false;
        }
   }
}