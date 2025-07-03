/*
 * Copyright (c) Contributors, http://opensimulator.org/
 * See CONTRIBUTORS.TXT for a full list of copyright holders.
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
using System;
using System.IO;
using System.Net;
using System.Reflection;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using log4net;

namespace OpenSim.ConsoleClient
{
    public delegate void ReplyDelegate(string requestUrl, string requestData, string replyData);

    public class Requester
    {
        public static void MakeRequest(string requestUrl, string data, ReplyDelegate action)
        {
            WebRequest request = WebRequest.Create(requestUrl);
            WebResponse response = null;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            byte[] buffer = new System.Text.ASCIIEncoding().GetBytes(data);
            int length = (int) buffer.Length;
            request.ContentLength = length;

            request.BeginGetRequestStream(delegate(IAsyncResult res)
            {
                Stream requestStream = request.EndGetRequestStream(res);
                requestStream.Write(buffer, 0, length);

                request.BeginGetResponse(delegate(IAsyncResult ar)
                {
                    string reply = String.Empty;
                    response = request.EndGetResponse(ar);

                    try
                    {
                        StreamReader r = new StreamReader(response.GetResponseStream()); reply = r.ReadToEnd();
                    }
                    catch (System.InvalidOperationException) {}
                    action(requestUrl, data, reply);
                }, null);
            }, null);
        }
    }
}
