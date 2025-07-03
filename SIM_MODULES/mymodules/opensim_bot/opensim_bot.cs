using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

using OpenMetaverse;
//using ObjectUpdate=OpenMetaverse.Primitive;
// ObjectMovementUpdate
//using OpenMetaverse.Packets;
//using OpenMetaverse.StructuredData;
//using OpenMetaverse.Type;
//using Nini.Config;
//using OpenSim.Region.Framework;
//using OpenSim.Region.Framework.Interfaces;
//using OpenSim.Region.Framework.Scenes;
//using OpenSim.Region.CoreModules;
//using OpenSim.Region.OptionalModules;
//using OpenSim.Services.Interfaces;
//using OpenSim.Services.AvatarService;
//using OpenSim.Services.MapImageService;
//using OpenSim.Services.PresenceService;
//using OpenSim.Services.SimulationService;
//using OpenSim.Framework;
//using OpenSim.Framework.Console;
//using OpenSim.Framework.Monitoring;
//using OpenSim.Framework.Client;
//using OpenSim.Framework.Servers.Statistics;
//using Timer = System.Timers.Timer;
//using AssetLandmark = OpenSim.Framework.AssetLandmark;

// create user NN Bot NN
// create user Diego Squire diego77
namespace MyPetBot
{
    class MyPetBot
    {
        private static volatile bool cancelled = false;

        public static GridClient client = new GridClient();
        private static string first_name = "NN";
        private static string last_name = "Bot";
        private static string password = "NN";        
        public static Vector3 startLoc = new Vector3(105, 103, 29); // Specify where the bot is to be logged in
        public static Vector3 pos = new Vector3();
        public static int turn_count = 0;
        private static float followDistance = 8;
        public static bool followon = false;
        // This is the name of the agent to follow
        public static string followName = "Diego Squire";


        public static void Main(string[] args)
        {
            AppDomain.CurrentDomain.UnhandledException += (sender, eventArgs) => Console.WriteLine("Something went wrong! " + args);
            Console.CancelKeyPress += new ConsoleCancelEventHandler(myHandler);


            // var dllDirectory = @"C:/XBIN";
            // Environment.SetEnvironmentVariable("PATH", Environment.GetEnvironmentVariable("PATH") + ";" + dllDirectory);
            // Console.WriteLine(Environment.GetEnvironmentVariable("PATH"));

            string startLocation = NetworkManager.StartLocation("BUBBA", (int) startLoc.X,(int) startLoc.Y,(int) startLoc.Z);

            // client.Network.SimConnected += new NetworkManager.ConnectedCallback(Network_OnConnected);
            client.Network.SimConnected +=  new EventHandler<SimConnectedEventArgs>(Network_OnConnected);

            client.Settings.LOGIN_SERVER = "http://127.0.0.1:9000/";
            string[] pointAtt = new string[8];
            if (client.Network.Login(first_name, last_name, password, "Killer Opensim Robot", startLocation, "Mr Diego"))
            {
                client.Network.SimConnected +=  Network_OnConnected;
                Console.WriteLine("Bot Login Message: " + client.Network.LoginMessage);
                client.Appearance.SetPreviousAppearance(false);

            }
        }
        public static void Objects_OnObjectUpdated(object sender, PrimEventArgs e) 
        // Simulator simulator, ObjectMovementUpdate update,  ulong regionHandle, ushort timeDilation)
        {
            if (followon == true)
            {
                Console.WriteLine("Target Moved");
                Console.WriteLine("Primitive {0} {1} in {2} is an attachment {3}", e.Prim.ID, e.Prim.LocalID, e.Simulator.Name, e.IsAttachment);
                //Exit this event if it's not an avatar update
                if (!e.Prim.IsAttachment) { return; }
                Avatar av;
                client.Network.CurrentSim.ObjectsAvatars.TryGetValue(e.Prim.LocalID, out av);
                if (av == null) return;
                
                if (av.Name == followName)
                {
                    pos = av.Position;
                    if (Vector3.Distance(pos, client.Self.SimPosition) > followDistance)
                    {
                        //int followRegionX = (int)(regionHandle >> 32);
                        //int followRegionY = (int)(regionHandle & 0xFFFFFFFF);
                        //int followRegionZ = (int)(regionHandle);
                        int followRegionX = 126;
                        int followRegionY = 122;
                        int followRegionZ = 25;
                        ulong x = (ulong)(pos.X + followRegionX);
                        ulong y = (ulong)(pos.Y + followRegionY);
                        turn_count++;
                        if (turn_count%10 == 1) client.Self.Movement.TurnToward(pos);
                        if (pos.Z > 1) { client.Self.AutoPilotLocal(Convert.ToInt32(pos.X), Convert.ToInt32(pos.Y), pos.Z); }
                        else { client.Self.AutoPilotCancel(); }
                    }
                    else { turn_count = 0; client.Self.Movement.TurnToward(pos); }
                }
                
            }
        }
        static void Network_OnConnected(object sender, SimConnectedEventArgs e)
        {
            Console.WriteLine("The bot is connected");
            client.Self.Movement.AlwaysRun = true;
            System.Threading.Thread.Sleep(1000);
            followon = true;
            client.Objects.ObjectUpdate += new EventHandler<PrimEventArgs>(Objects_OnObjectUpdated);
        }
        
        private void WhenItStopsDoThis(object sender, EventArgs e) { Console.WriteLine("Exitting"); }
        protected static void myHandler(object sender, ConsoleCancelEventArgs args)
        {
            Console.WriteLine("CANCEL command received! Cleaning up. please wait...");
            args.Cancel = true;
            // Program.cancelled = true;
            client.Network.Logout();
            //client.Network.DisconnectSim();
            Environment.Exit(-1);
        }

     }
}
