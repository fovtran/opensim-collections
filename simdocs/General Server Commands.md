### General Server Commands
These commands are available in both simulator and robust consoles.

General
command-script [scriptfile] - Runs a command script containing console commands.
quit - shutdown the server.
show info - show server information (version and startup path). Before OpenSimulator 0.7.5 this is only available on the simulator console.
show uptime - show server startup time and uptime. Before OpenSimulator 0.7.5 this is only available on the simulator console.
show version - show server version. Before OpenSimulator 0.7.5 this is only available on the simulator console.
shutdown - synonym for quit
get log level - In OpenSimulator 0.7.5 and later, print the current console logging level. In OpenSimulator 0.7.4 and earlier please use the "set log level" command instead without a level parameter.
set log level [level] - change the console logging level only. For example, off or debug. See Logging for more information. In OpenSimulator 0.7.4 and earlier, if called without the level argument prints the current level. In OpenSimulator 0.7.5 and later please use the "get log level" command instead. Only available on ROBUST console from OpenSimulator 0.7.5.
Debug
debug http [<level>] - Turn on/off extra logging for HTTP request debugging. Only available on robust console from commit 94517c8 (dev code post 0.7.3.1). In current development code (for OpenSimulator 0.7.5) this is debug http in|out|all [<level>] since outbound HTTP messages can also now be logged (this was only possible for inbound before). For more information on this command, see Debugging.
debug threadpool level <level> - Turn on/off logging of activity in the main threadpool. For more information, see General-Purpose Threadpool.
