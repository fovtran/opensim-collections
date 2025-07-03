/*
 * Copyright (c) Contributors, http://opensimulator.org/
 * See CONTRIBUTORS.TXT for a full list of copyright holders.
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using OpenMetaverse;
using log4net;
using log4net.Appender;
using log4net.Layout;
using OpenSim.Framework;
using OpenSim.Services.Interfaces;
using OpenSim.Services.Connectors;

namespace OpenSim.Tests.Clients.PresenceClient
{
    public class UserAccountsClient
    {
        private static readonly ILog m_log =
                LogManager.GetLogger(
                MethodBase.GetCurrentMethod().DeclaringType);
        
        public static void Main(string[] args)
        {
            ConsoleAppender consoleAppender = new ConsoleAppender();
            consoleAppender.Layout =
                new PatternLayout("%date [%thread] %-5level %logger [%property{NDC}] - %message%newline");
            log4net.Config.BasicConfigurator.Configure(consoleAppender);

            string serverURI = "http://127.0.0.1:8003";
            UserAccountServicesConnector m_Connector = new UserAccountServicesConnector(serverURI);

            UUID user1 = UUID.Random();
            string first = "Completely";
            string last = "Clueless";
            string email = "foo@bar.com";

            UserAccount account = new UserAccount(user1);
            account.FirstName = first;
            account.LastName = last;
            account.Email = email;
            account.ServiceURLs = new Dictionary<string, object>();
            account.ServiceURLs.Add("InventoryServerURI", "http://cnn.com");
            account.ServiceURLs.Add("AssetServerURI", "http://cnn.com");

            bool success = m_Connector.StoreUserAccount(account);
            if (success)
                m_log.InfoFormat("[USER CLIENT]: Successfully created account for user {0} {1}", account.FirstName, account.LastName);
            else
                m_log.InfoFormat("[USER CLIENT]: failed to create user {0} {1}", account.FirstName, account.LastName);

            System.Console.WriteLine("\n");

            account = m_Connector.GetUserAccount(UUID.Zero, user1);
            if (account == null)
                m_log.InfoFormat("[USER CLIENT]: Unable to retrieve accouny by UUID for {0}", user1);
            else
            {
                m_log.InfoFormat("[USER CLIENT]: Account retrieved correctly: userID={0}; FirstName={1}; LastName={2}; Email={3}",
                                  account.PrincipalID, account.FirstName, account.LastName, account.Email);
                foreach (KeyValuePair<string, object> kvp in account.ServiceURLs)
                    m_log.DebugFormat("\t {0} -> {1}", kvp.Key, kvp.Value);
            }

            System.Console.WriteLine("\n");

            account = m_Connector.GetUserAccount(UUID.Zero, first, last);
            if (account == null)
                m_log.InfoFormat("[USER CLIENT]: Unable to retrieve accouny by name for {0}", user1);
            else
            {
                m_log.InfoFormat("[USER CLIENT]: Account retrieved correctly: userID={0}; FirstName={1}; LastName={2}; Email={3}",
                                  account.PrincipalID, account.FirstName, account.LastName, account.Email);
                foreach (KeyValuePair<string, object> kvp in account.ServiceURLs)
                    m_log.DebugFormat("\t {0} -> {1}", kvp.Key, kvp.Value);
            }

            System.Console.WriteLine("\n");
            account = m_Connector.GetUserAccount(UUID.Zero, email);
            if (account == null)
                m_log.InfoFormat("[USER CLIENT]: Unable to retrieve accouny by email for {0}", user1);
            else
            {
                m_log.InfoFormat("[USER CLIENT]: Account retrieved correctly: userID={0}; FirstName={1}; LastName={2}; Email={3}",
                                  account.PrincipalID, account.FirstName, account.LastName, account.Email);
                foreach (KeyValuePair<string, object> kvp in account.ServiceURLs)
                    m_log.DebugFormat("\t {0} -> {1}", kvp.Key, kvp.Value);
            }

        }

    }
}
