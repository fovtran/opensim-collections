using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using OpenMetaverse;
using OpenMetaverse.Packets;
using OpenMetaverse.StructuredData;
using OpenMetaverse.Messages.Linden;
//using OpenMetaverseTypes;
using Nini.Config;
using OpenSim.Region.Framework;
using OpenSim.Region.Framework.Interfaces;
using OpenSim.Region.Framework.Scenes;
using OpenSim.Region.CoreModules;
using OpenSim.Region.OptionalModules;
using OpenSim.Services.Interfaces;
using OpenSim.Services.AvatarService;
using OpenSim.Services.MapImageService;
using OpenSim.Services.PresenceService;
using OpenSim.Services.SimulationService;

using OpenSim.Framework;
using OpenSim.Framework.Console;
using OpenSim.Framework.Monitoring;
using OpenSim.Framework.Client;
//using OpenSim.Framework.Servers.Statistics;
using Timer = System.Timers.Timer;
using AssetLandmark = OpenSim.Framework.AssetLandmark;

namespace MyPetBot
{
    class MyPetBot
    {
        public static GridClient client = new GridClient();
        private static string first_name = "Chip";
        private static string last_name = "Chip";
        private static string password = "000";
        public static Vector3d startLoc = new Vector3d(28, 28, 22);
        public static Vector3 pos = new Vector3();
        public static int turn_count = 0;
        private static float followDistance = 8;
        public static bool followon = false;
        // This is the name of the agent to follow
        public static string followName = "Maria Soma";
        public static void Main()
        {
            string startLocation = NetworkManager.StartLocation("Home", (int) startLoc.X,(int) startLoc.Y,(int) startLoc.Z);
			//client.Network.LoginResponseCallback += new NetworkManager.LoginResponseCallback(Network_OnConnected);

            client.Settings.LOGIN_SERVER = "http://osgrid.org:8002";
            string[] pointAtt = new string[8];
            if (client.Network.Login(first_name, last_name, password, "OSGridRobot", startLocation, "OSGrid Robot"))
            {
                //	client.Network.OnConnected += new NetworkManager.ConnectedCallback(Network_OnConnected);
                Console.WriteLine("Bot Login Message: " + client.Network.LoginMessage);
                //client.Appearance.SetPreviousAppearance(false);
            }
        }
        public static void Objects_OnObjectUpdated(Simulator simulator, ObjectMovementUpdate update,  ulong regionHandle, ushort timeDilation)
        {
            if (followon == true)
            {                
                if (!update.Avatar) { return; } //Exit this event if it's not an avatar update
                Avatar av;
                client.Network.CurrentSim.ObjectsAvatars.TryGetValue(update.LocalID, out av);
                if (av == null) return;
                if (av.Name == followName)
                {
                    pos = av.Position;
                    if (Vector3.Distance(pos, client.Self.SimPosition) > followDistance)
                    {
                        int followRegionX = (int)(regionHandle >> 32);
                        int followRegionY = (int)(regionHandle & 0xFFFFFFFF);
                        int followRegionZ = (int)(regionHandle);
                        ulong x = (ulong)(pos.X + followRegionX);
                        ulong y = (ulong)(pos.Y + followRegionY);
                        turn_count++;
                        if (turn_count%10 == 1) client.Self.Movement.TurnToward(pos);
                        if (pos.Z > 1)
                        {
                            client.Self.AutoPilotLocal(Convert.ToInt32(pos.X), Convert.ToInt32(pos.Y), pos.Z);
                        }
                        else
                        {
                            client.Self.AutoPilotCancel();
                        }
                    }
                    else
                    {
                        turn_count = 0;
                        client.Self.Movement.TurnToward(pos);
                    }
                }
            }
        
			
        static void Network_OnConnected(object sender)
        {
            Console.WriteLine("The bot is connected");
            client.Self.Movement.AlwaysRun = false;
            System.Threading.Thread.Sleep(3000);
            followon = true;
            //client.Objects.OnObjectMovementUpdated += new ObjectManager.ObjectUpdatedCallback(Objects_OnObjectUpdated);
        }
     }
}
