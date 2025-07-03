//MRM:C#
/*=============================================================

================================================================*/
using System.IO;
using System.Net;
using System.Text;
using OpenSim.Region.OptionalModules.Scripting.Minimodule;
using OpenMetaverse;

namespace OpenSim{
   class MiniModule : MRMBase
   {
      public override void Start()
        {   
            Host.Object.OnTouch += OnTouched;
            Host.Object.Text = "Touch to make a http Request to geocoder.us";  
        }

      void OnTouched(IObject sender, TouchEventArgs e)
        {
           try
            {
                StringBuilder sb = new StringBuilder();
                byte[] buf = new byte[8192];
                HttpWebRequest request =
                    (HttpWebRequest) WebRequest.Create("http://rpc.geocoder.us/service/csv?address=1600+Pennsylvania+Ave,+Washington+DC");
                HttpWebResponse response = (HttpWebResponse) request.GetResponse();
                Stream resStream = response.GetResponseStream();
                string tempString = null;
                int count = 0;

                do
                {
                    count = resStream.Read(buf, 0, buf.Length);
                    if (count != 0)
                    {
                        tempString = Encoding.ASCII.GetString(buf, 0, count);
                        sb.Append(tempString);
                    }
                } while (count > 0);
                Host.Object.Say(sb.ToString());
            }
            catch (WebException) { Host.Object.Say("WebException occured"); }                                               
        }

      public override void Stop() { }
   }
} 