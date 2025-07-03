#!/bin/bash
#
# FILENAME: Start_OS.sh
# AUTHOR: WhiteStar Magic @ OSGrid
# DATE: August.20.2009
# REVISION: 1.0 (initial release)
#
# DESCRIPTION: Starts OpenSim.exe with some pre-processing
# - Checks to see if Backup folders exist and if not creates backup folder structures (see MAKE_dirs)
# - copies opensim.log from /BIN folder to Log Backup & renames it to OSLOG_Date-time.log
# - example of output OSLOG_16082009-1008.log
# - then it CLEARS the log to EMPTY in the /BIN folder so you can see everything from startup
# - WHY? Easier to track startup issues / debugging and helps reduce size of live opensim.log
# - Copies out Several key pieces of data and stores them in the /INSTANCE/BACKup Structure
# - Copies out *.DB files (SqlLite) into the BACKup/DB directory
# - Performs a MySql Dump to BACKup/DBsql of the MySql Databases **
# ** Handles Multiple MySql DB's or Single opensim db. See Section for detailed explanation
# 
# INSTALLATION:
# copy this script into /opt and run with the following command bash Start_OS.sh
# can be installed in another directory, Adjust the script accordingly
#
# The following need to be configured within the script for EVERY INSTANCE: (detailed comments in FIRST INSTANCE)
#
# OSInstance="/opensim/instance_1" <- Location of your OpenSimulator Instance
# OSbackup="/BACKup" <- Root Directory for Backup Structure ("/opensim/instance_1/BACKup")
# DBusr="DATABASE_USER_NAME" <- User Name for MySql DB Access (leave blank if using SqlLite)
# DBpw="DATABASE_PASSWORD" <- Password for MySql DB Access " "
# DBname="opensim" <- Database Name for MySql " " 
# 
# KUDOS & THANKS: 
# Thanks a LOT to the following individuals @ OSGrid 
# Coyled, BWild, Godfrey, Hiro, DeneSparta and the rest of the gang! THANKS GUYS !
# An Excellent Resource for anyone interested in BASH scripting: http://tldp.org/LDP/abs/html/
#
# -------------------------------------------------------------------------------------------------
# OSbackup = Where you want your Backup File Structure to be and send files to
# This will create the structure as: /INSTANCENAME/BACKup with the complete Sub-Structure beneath it
#
OSbackup="/BACKup"
echo OSbackup = $OSbackup
# --------------------------------------------------------------------------------------
# DATE & TIME String Assembly
# --------------------------------------------------------------------------------------
# Date & Time Format on your system
# 
# date %F = (%Y%m%d)
# date %H = 24 hr, %M - Minutes
# 
TimeStamp=`date +%d%m%Y-%H%M`
# we now have a string which will appear as 16082009-1008
# --------------------------------------------------------------------------------------
echo TimeStamp = $TimeStamp
# ---------------------------------------------------------------------------------------
# === Make Backup Folders function ===
MAKE_dirs()
{
echo Error: Backup Folders do not exist, Creating structure
mkdir -v ${OSInstance}${OSbackup}
mkdir -v ${OSInstance}${OSbackup}/DB
mkdir -v ${OSInstance}${OSbackup}/DBsql
mkdir -v ${OSInstance}${OSbackup}/INI
mkdir -v ${OSInstance}${OSbackup}/EXPORTS
mkdir -v ${OSInstance}${OSbackup}/LOGS
mkdir -v ${OSInstance}${OSbackup}/OAR
mkdir -v ${OSInstance}${OSbackup}/REGIONS
mkdir -v ${OSInstance}${OSbackup}/TERRAINS
mkdir -v ${OSInstance}${OSbackup}/TXT
mkdir -v ${OSInstance}${OSbackup}/XML2
sleep 3
# Sleeps for 3 seconds to allow for server to update properly
}
#
# ---------------------------------------------------------------------------------------
# === File Copy & Archiving Function ===
COPY_files()
{
# copy log file over
cp ${OSInstance}/bin/OpenSim.log ${OSInstance}${OSbackup}/LOGS/OpenSim.log
mv ${OSInstance}${OSbackup}/LOGS/OpenSim.log ${OSInstance}${OSbackup}/LOGS/OSlog_${TimeStamp}.log
# 
# NEXT FLUSHING LOG to EMPTY
echo LOG_CLEARED AT ${TimeStamp} > ${OSInstance}/bin/OpenSim.log
# 
# NEXT copy out the estate info from /bin
cp ${OSInstance}/bin/estate_settings.xml ${OSInstance}${OSbackup}/LOGS/estate_settings.xml
#
# NEXT we copy the *.DB files for SqlLite IF they are in use. These all have DB extension
rsync -r --prune-empty-dirs --progress --filter '+ *.db' --filter '+ */' --filter '- *' ${OSInstance}/bin/* ${OSInstance}${OSbackup}/DB/
#
# NEXT we get MySql DB Dump
if [ ${DBusr}tst != "tst" ]; then
echo MySql DB Backup of ${DBname} being processed
mysqldump --opt -u${DBusr} -p${DBpw} ${DBname} > ${OSInstance}${OSbackup}/DBsql/${DBname}.sql
fi;
#
# copying ALL txt files over (safety precaution if you have console scripts or other text files located in /BIN+ folders)
rsync -r --prune-empty-dirs --progress --filter '+ *.txt' --filter '+ */' --filter '- *' ${OSInstance}/TXT/* 
#
# copying ALL ini files over
rsync -r --prune-empty-dirs --progress --filter '+ *.ini' --filter '+ */' --filter '- *' ${OSInstance}/bin/* ${OSInstance}${OSbackup}/INI/
#
# copy regions files over 
cp -r -u -p ${OSInstance}/bin/Regions/*.* ${OSInstance}${OSbackup}/REGIONS
#
# copy exports files over 
cp -r -u -p ${OSInstance}/bin/exports/* ${OSInstance}${OSbackup}/EXPORTS
#
# MAKE A TAR.GZ Compressed FILE of the backup data. Delete previous one, generate new one with TimeStamp
rm -f ${OSInstance}${OSbackup}/BACKUP_*.tar.gz 
tar --create --gzip --file=${OSInstance}${OSbackup}/BACKUP_${TimeStamp}.tar.gz ${OSInstance}${OSbackup}/*
}
#
# =====================================
# === NOW for the Instance Startups ===
# =====================================
# === COMMENTED READ CAREFULLY ===
# =====================================
# --- FIRST INSTANCE ---
#
# --- set pathing next
# OSInstance = Where the OpenSimulator Instance is installed, SET AT EVERY INSTANCE
# This is NOT the BIN Folder. It is one folder ABOVE the /bin
#
OSInstance="/opensim/INSTANCE_1"
#
# --- MySql Database Information to backup MySql DataBase ---
# !!! NOTE !!! By Default only ONE database is used "opensim" so only make one backup
# Some Installations have a unique DB for each instance so backup individual DB's
# The following info is located in your OpenSim.ini where you configured MySql Databases, See Next Line Example.
# storage_connection_string="Data Source=localhost;Database=opensim;User ID=root;Password=***password***;";
# DBusr = MySql DB User Name, default = root (not recomended)
# DBpwd = MySql DB Password, for the user account
# DBname= MySql Database Name, default is usually "opensim"
# The Following Variables MUST be set for each instance IF unique DB's are running.
# IF you only have ONE DB "opensim" Blank the variables AFTER the first backup
#
DBusr="DATABASE_USER_NAME"
DBpw="DATABASE_PASSWORD" 
DBname="opensim"
#
echo OSInstance = $OSInstance
cd ${OSInstance}
#
# --- test to see if backup folders exist, if not make them
if [ ! -e "${OSInstance}${OSbackup}" ]; then MAKE_dirs; fi
#
# --- Process & Copy important files
COPY_files
# 
# STARTING OPENSIM
# change directory to /bin to make sure and startup system as usual
cd ${OSInstance}/bin
echo we are are starting up OPENSIM Instance in ${OSInstance}/bin 
# Start Screen commands
# -d Detach the elsewhere running screen (and reattach here).
# -m ignore $STY variable, do create a new screen session.
# INSTANCE_* = Descriptive name for the SCREEN for identification
#
screen -S INSTANCE_1 -d -m mono OpenSim.exe -gui=true
# screen -S INSTANCE_1 -d -m mono OpenSim.32BitLaunch.exe -gui=true
#
# NOTE !! USE "OpenSim.32BitLaunch.exe" if running on 64-bit Operating system
sleep 3
#
# sleep is here because systems need a bit of time to not overload the server
# Adjust according to need
# -----------------------
# --- SECOND INSTANCE ---
#
OSInstance="/opensim/INSTANCE_2"
DBusr="DATABASE_USER_NAME"
DBpw="DATABASE_PASSWORD"
DBname="opensim"
cd ${OSInstance}
#
if [ ! -e "${OSInstance}${OSbackup}" ]; then MAKE_dirs; fi
#
COPY_files
#
cd ${OSInstance}/bin
echo we are are starting up OPENSIM Instance in ${OSInstance}/bin 
screen -S INSTANCE_2 -d -m mono OpenSim.exe -gui=true
# screen -S INSTANCE_2 -d -m mono OpenSim.32BitLaunch.exe -gui=true
sleep 3
# ----------------------
# --- THIRD INSTANCE ---
#
OSInstance="/opensim/INSTANCE_3"
DBusr="DATABASE_USER_NAME"
DBpw="DATABASE_PASSWORD" 
DBname="opensim"
cd ${OSInstance}
#
if [ ! -e "${OSInstance}${OSbackup}" ]; then MAKE_dirs; fi
#
COPY_files
#
cd ${OSInstance}/bin
echo we are are starting up OPENSIM Instance in ${OSInstance}/bin 
screen -S INSTANCE_3 -d -m mono OpenSim.exe -gui=true
# screen -S INSTANCE_3 -d -m mono OpenSim.32BitLaunch.exe -gui=true
sleep 3
#
# === END of Server-2 Startup Processing
# --- show the screen list to verify that the instances are all running as they should be. 
screen -ls 
sleep 10
