#! /usr/bin/env python
#  -*- coding: utf-8 -*-

import configparser
import uuid
import random
import random

# Vari
maplocation = ''
counter = 0
mapsprung = 0
xcounter = 0
ycounter = 0
regionsintnr = 0
mapintcounter = 0

# random name
def randomname():
    name = random.choice(['Abod', 'Adalbeort', 'Adalgar', 'Adham', 'Adken', 'Adulfuns',Klamweb', 'Schetz']);
    return name;

# make a random location, wird nicht mehr aufgerufen und ist nur noch als Information hier.
def randomlocation():
    maplocation = random.randrange(1000, 8000, 4)
    localmap = str(maplocation)
    return localmap;

# Map zusammenbauen
def osmap(mapx, mapy):
    global maplocation
    mapxstr = str(mapx) # int to str
    mapystr = str(mapy) # int to str
    maplocation = mapxstr + ',' + mapystr # zusammenbauen zu Beispiel: 1000,1000
    return maplocation;

# see if the user has entered a value or if it is random.
# TODO: Doppelte vermeiden!!! durch addieren von mapintcounter geloest
def randomport():
    myport = random.randrange(9100, 9999, 4) ++ mapintcounter
    return myport;

# see if the user has entered a value or if it is random.
def randomuuid():
    randomuuid = uuid.uuid4()
    return randomuuid;

# create a config file
def write_region(mapintcounter, regionsintnr):
    config = configparser.ConfigParser()
    global counter, xcounter, ycounter, maplocation

    # capitalization gross- kleinschreibung beachten
    config.optionxform = str

    # generate a uuid for all entries
    ruuid = str(entryRegionUUID.get()) # Holt die Daten aus der Eingabe, hier die RegionUUID.
    if ruuid=='' : ruuid = randomuuid() # Wenn leer dann eine Zufallszahl generieren.

    # InternalPort
    InternalPort = str(entryInternalPort.get()) # Holt die Daten aus der Eingabe, hier der InternalPort.
    if InternalPort=='' : InternalPort = random.randrange(9100, 9999, 4) ++ mapintcounter # Wenn leer dann eine Zufallszahl generieren.

    # MaxPrims
    MaxPrims = str(entryMaxPrims.get()) # Holt die Daten aus der Eingabe, hier MaxPrims.
    if MaxPrims=='' : MaxPrims = '10000' # Wenn leer dann vorgabe verwenden.

    # MaxAgents
    MaxAgents = str(entryMaxAgents.get()) # Holt die Daten aus der Eingabe, hier MaxAgents.
    if MaxAgents=='' : MaxAgents = '20' # Wenn leer dann vorgabe verwenden.

    # AllowAlternatePorts
    AllowAlternatePorts = str(entryAllowAlternatePorts.get()) # Holt die Daten aus der Eingabe
    if AllowAlternatePorts=='' : AllowAlternatePorts = 'False' # Wenn leer dann vorgabe verwenden.

    # ResolveAdress
    ResolveAdress = str(entryResolveAdress.get()) # Holt die Daten aus der Eingabe
    if ResolveAdress=='' : ResolveAdress = 'False' # Wen leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkResolveAdress.get()==0 : checkResolveAdressoff = ';' # Einstellung ein- ausschalten.
    else: checkResolveAdressoff = ''

    # DefaultLanding
    DefaultLanding = str(entryDefaultLanding.get()) # Holt die Daten aus der Eingabe
    if DefaultLanding=='' : DefaultLanding = '128,128,21' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkDefaultLanding.get()==0 : checkDefaultLandingoff = ';' # Einstellung ein- ausschalten.
    else: checkDefaultLandingoff = ''

    # NonPhysicalPrimMax
    NonPhysicalPrimMax = str(entryNonPhysicalPrimMax.get()) # Holt die Daten aus der Eingabe
    if NonPhysicalPrimMax=='' : NonPhysicalPrimMax = '1024' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkNonPhysicalPrimMax.get()==0 : checkNonPhysicalPrimMaxoff = ';' # Einstellung ein- ausschalten.
    else: checkNonPhysicalPrimMaxoff = ''

    # PhysicalPrimMax
    PhysicalPrimMax = str(entryPhysicalPrimMax.get()) # Holt die Daten aus der Eingabe
    if PhysicalPrimMax=='' : PhysicalPrimMax = '64' # Wen leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkPhysicalPrimMax.get()==0 : checkPhysicalPrimMaxoff = ';' # Einstellung ein- ausschalten.
    else: checkPhysicalPrimMaxoff = ''

    # ClampPrimSize
    ClampPrimSize = str(entryClampPrimSize.get()) # Holt die Daten aus der Eingabe
    if ClampPrimSize=='' : ClampPrimSize = 'False' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkClampPrimSize.get()==0 : checkClampPrimSizeoff = ';' # Einstellung ein- ausschalten.
    else: checkClampPrimSizeoff = ''

    # MaxPrimsPerUser
    MaxPrimsPerUser = str(entryMaxPrimsPerUser.get()) # Holt die Daten aus der Eingabe
    if MaxPrimsPerUser=='' : MaxPrimsPerUser = '-1' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMaxPrimsPerUser.get()==0 : checkMaxPrimsPerUseroff = ';' # Einstellung ein- ausschalten.
    else: checkMaxPrimsPerUseroff = ''

    # ScopeID
    ScopeID = str(entryScopeID.get()) # Holt die Daten aus der Eingabe
    if ScopeID=='' : ScopeID = ruuid # Wen leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkScopeID.get()==0 : checkScopeIDoff = ';' # Einstellung ein- ausschalten.
    else: checkScopeIDoff = ''

    # RegionType
    RegionType = str(entryRegionType.get()) # Holt die Daten aus der Eingabe
    if RegionType=='' : RegionType = 'Mainland' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkRegionType.get()==0 : checkRegionTypeoff = ';' # Einstellung ein- ausschalten.
    else: checkRegionTypeoff = ''

    #entryMaptileStaticUUID
    MaptileStaticUUID = str(entryMaptileStaticUUID.get()) # Holt die Daten aus der Eingabe
    if MaptileStaticUUID=='' : MaptileStaticUUID = ruuid # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMaptileStaticUUID.get()==0 : checkMaptileStaticUUIDoff = ';' # Einstellung ein- ausschalten.
    else: checkMaptileStaticUUIDoff = ''

    # MaptileStaticFile
    MaptileStaticFile = str(entryMaptileStaticFile.get()) # Holt die Daten aus der Eingabe
    if MaptileStaticFile=='' : MaptileStaticFile = '"water.jpg"' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMaptileStaticFile.get()==0 : checkMaptileStaticFileoff = ';' # Einstellung ein- ausschalten.
    else: checkMaptileStaticFileoff = ''

    # MasterAvatarFirstName
    MasterAvatarFirstName = str(entryMasterAvatarFirstName.get()) # Holt die Daten aus der Eingabe
    if MasterAvatarFirstName=='' : MasterAvatarFirstName = 'John' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMasterAvatarFirstName.get()==0 : checkMasterAvatarFirstNameoff = ';' # Einstellung ein- ausschalten.
    else: checkMasterAvatarFirstNameoff = ''

    # MasterAvatarLastName
    MasterAvatarLastName = str(entryMasterAvatarLastName.get()) # Holt die Daten aus der Eingabe
    if MasterAvatarLastName=='' : MasterAvatarLastName = 'Doe' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMasterAvatarLastName.get()==0 : checkMasterAvatarLastNameoff = ';' # Einstellung ein- ausschalten.
    else: checkMasterAvatarLastNameoff = ''

    # MasterAvatarSandboxPassword
    MasterAvatarSandboxPassword = str(entryMasterAvatarSandboxPassword.get()) # Holt die Daten aus der Eingabe
    if MasterAvatarSandboxPassword=='' : MasterAvatarSandboxPassword = 'passwd' # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkMasterAvatarSandboxPassword.get()==0 : checkMasterAvatarSandboxPasswordoff = ';' # Einstellung ein- ausschalten.
    else: checkMasterAvatarSandboxPasswordoff = ''

    # InternalAddress
    InternalAddress = str(entryInternalAddress.get()) # Holt die Daten aus der Eingabe
    if InternalAddress =='' : InternalAddress = "0.0.0.0" # Wenn leer dann vorgabe verwenden.
    # Einstellung ein- ausschalten.
    if checkResolveAdress.get()==0 : checkResolveAdressoff = ';' # Einstellung ein- ausschalten.
    else: checkResolveAdressoff = ''

    # ExternalHostName
    ExternalHostName = str(entryExternalHostName.get()) # Holt die Daten aus der Eingabe, hier ExternalHostName.
    if ExternalHostName =='' : ExternalHostName = "SYSTEMIP" # Wenn leer dann vorgabe verwenden.

    # mapliste: 0 = mapx, 1 = mapy, 2 = mapsprung var
    mapliste = ["0", "1", "2"] # ich benutze hier eine liste zum konvertieren von string und integer weil ich sonst probleme von str nach int habe

    # Size
    Size_var = entrySize.get() # Holt die Daten aus der Eingabe, hier Size.
    if Size_var=='' : Size_var = "256"
    mapliste[2] = Size_var # listeneintrag 2 ueberschreiben zum konvertieren von str to int
    mapsprung = int(mapliste[2])//256 # beruecksichtigung von var regionen / = teilen mit komma // = teilen ohne komma - Beispiele: 1 = 256 single region ... 4 = var region 1024

    # assemble region location
    maplocationx = entryLocationx.get() # Holt den string aus der Eingabe, hier die maplocation.
    maplocationy = entryLocationy.get() # Holt den string aus der Eingabe, hier die maplocation.

    if maplocationx =='' : maplocationx = random.randrange(1000, 8000, 4) # Zufallszahl generieren
    if maplocationy =='' : maplocationy = random.randrange(1000, 8000, 4) # Zufallszahl generieren

    mapliste[0] = maplocationx # listeneintrag 0 ueberschreiben
    mapliste[1] = maplocationy # listeneintrag 1 ueberschreiben

    maplocationxinteger = int(mapliste[0]) # listeneintrag 0 als integer speichern
    maplocationyinteger = int(mapliste[1]) # listeneintrag 1 als integer speichern

    ### Aneinanderreien von Regionen als Block ohne random.
    if mapintcounter == 0: osmap(maplocationxinteger + 0,maplocationyinteger + 0)
    if mapintcounter == 1: osmap(maplocationxinteger + 1,maplocationyinteger + 0)
    if mapintcounter == 6: osmap(maplocationxinteger + 2,maplocationyinteger + 0)
    if mapintcounter == 12: osmap(maplocationxinteger + 3,maplocationyinteger + 0)
    if mapintcounter == 20: osmap(maplocationxinteger + 4,maplocationyinteger + 0)
    if mapintcounter == 30: osmap(maplocationxinteger + 5,maplocationyinteger + 0)
    if mapintcounter == 42: osmap(maplocationxinteger + 6,maplocationyinteger + 0)

    if mapintcounter == 2: osmap(maplocationxinteger + 0,maplocationyinteger + 1)
    if mapintcounter == 3: osmap(maplocationxinteger + 1,maplocationyinteger + 1)
    if mapintcounter == 7: osmap(maplocationxinteger + 2,maplocationyinteger + 1)
    if mapintcounter == 13: osmap(maplocationxinteger + 3,maplocationyinteger + 1)
    if mapintcounter == 21: osmap(maplocationxinteger + 4,maplocationyinteger + 1)
    if mapintcounter == 31: osmap(maplocationxinteger + 5,maplocationyinteger + 1)
    if mapintcounter == 43: osmap(maplocationxinteger + 6,maplocationyinteger + 1)

    if mapintcounter == 4: osmap(maplocationxinteger + 0,maplocationyinteger + 2)
    if mapintcounter == 5: osmap(maplocationxinteger + 1,maplocationyinteger + 2)
    if mapintcounter == 8: osmap(maplocationxinteger + 2,maplocationyinteger + 2)
    if mapintcounter == 14: osmap(maplocationxinteger + 3,maplocationyinteger + 2)
    if mapintcounter == 22: osmap(maplocationxinteger + 4,maplocationyinteger + 2)
    if mapintcounter == 32: osmap(maplocationxinteger + 5,maplocationyinteger + 2)
    if mapintcounter == 44: osmap(maplocationxinteger + 6,maplocationyinteger + 2)

    if mapintcounter == 9: osmap(maplocationxinteger + 0,maplocationyinteger + 3)
    if mapintcounter == 10: osmap(maplocationxinteger + 1,maplocationyinteger + 3)
    if mapintcounter == 11: osmap(maplocationxinteger + 2,maplocationyinteger + 3)
    if mapintcounter == 15: osmap(maplocationxinteger + 3,maplocationyinteger + 3)
    if mapintcounter == 23: osmap(maplocationxinteger + 4,maplocationyinteger + 3)
    if mapintcounter == 33: osmap(maplocationxinteger + 5,maplocationyinteger + 3)
    if mapintcounter == 45: osmap(maplocationxinteger + 6,maplocationyinteger + 3)

    if mapintcounter == 16: osmap(maplocationxinteger + 0,maplocationyinteger + 4)
    if mapintcounter == 17: osmap(maplocationxinteger + 1,maplocationyinteger + 4)
    if mapintcounter == 18: osmap(maplocationxinteger + 2,maplocationyinteger + 4)
    if mapintcounter == 19: osmap(maplocationxinteger + 3,maplocationyinteger + 4)
    if mapintcounter == 24: osmap(maplocationxinteger + 4,maplocationyinteger + 4)
    if mapintcounter == 34: osmap(maplocationxinteger + 5,maplocationyinteger + 4)
    if mapintcounter == 46: osmap(maplocationxinteger + 6,maplocationyinteger + 4)

    if mapintcounter == 25: osmap(maplocationxinteger + 0,maplocationyinteger + 5)
    if mapintcounter == 26: osmap(maplocationxinteger + 1,maplocationyinteger + 5)
    if mapintcounter == 27: osmap(maplocationxinteger + 2,maplocationyinteger + 5)
    if mapintcounter == 28: osmap(maplocationxinteger + 3,maplocationyinteger + 5)
    if mapintcounter == 29: osmap(maplocationxinteger + 4,maplocationyinteger + 5)
    if mapintcounter == 35: osmap(maplocationxinteger + 5,maplocationyinteger + 5)
    if mapintcounter == 47: osmap(maplocationxinteger + 6,maplocationyinteger + 5)

    if mapintcounter == 36: osmap(maplocationxinteger + 0,maplocationyinteger + 6)
    if mapintcounter == 37: osmap(maplocationxinteger + 1,maplocationyinteger + 6)
    if mapintcounter == 38: osmap(maplocationxinteger + 2,maplocationyinteger + 6)
    if mapintcounter == 39: osmap(maplocationxinteger + 3,maplocationyinteger + 6)
    if mapintcounter == 40: osmap(maplocationxinteger + 4,maplocationyinteger + 6)
    if mapintcounter == 41: osmap(maplocationxinteger + 5,maplocationyinteger + 6)
    if mapintcounter == 48: osmap(maplocationxinteger + 6,maplocationyinteger + 6)

    if mapintcounter == 49: osmap(maplocationxinteger + 0,maplocationyinteger + 7)
    if mapintcounter == 50: osmap(maplocationxinteger + 1,maplocationyinteger + 7)
    if mapintcounter == 51: osmap(maplocationxinteger + 2,maplocationyinteger + 7)
    if mapintcounter == 52: osmap(maplocationxinteger + 3,maplocationyinteger + 7)
    if mapintcounter == 53: osmap(maplocationxinteger + 4,maplocationyinteger + 7)
    if mapintcounter == 54: osmap(maplocationxinteger + 5,maplocationyinteger + 7)
    if mapintcounter == 55: osmap(maplocationxinteger + 6,maplocationyinteger + 7)

    # 55 Reihen als Block sind fertig. LibreOffice Calc hat das so sortiert.


    # Ab 56 einfach den counter erhoehen.
    if mapintcounter >= 56: # Ist der counter = 0 die angegebene Position nutzen, ansonsten zaehler unter beruecksichtigung der Regionsgroesse hochsetzen.
        if mapintcounter % 2:
            # ist der counter ungrade, localisation x zaehler hoch setzen

            #maplocationxinteger += counter # vor der beruecksichtigung der var groesse
            maplocationxinteger += mapintcounter # vor der beruecksichtigung der var groesse

            if mapsprung > 1: maplocationxinteger += mapsprung # nach der beruecksichtigung der var groesse
            osmap(maplocationxinteger, maplocationyinteger) # Neu map Beispiel: map(1000, 1000) ergibt eine variable string mit dem inhalt 1000,1000 die direkt in die config geschrieben werden kann.
            #print(mapintcounter, regionsintnr)
        else:
            # oder ist der counter grade, localisation y zaehler hoch setzen
            #maplocationyinteger += counter # vor der beruecksichtigung der var groesse
            maplocationyinteger += mapintcounter # vor der beruecksichtigung der var groesse
            if mapsprung > 1: maplocationyinteger += mapsprung # nach der beruecksichtigung der var groesse
            osmap(maplocationxinteger, maplocationyinteger) # Neu map Beispiel: map(1000, 1000) ergibt eine variable string mit dem inhalt 1000,1000 die direkt in die config geschrieben werden kann.
            #print(mapintcounter, regionsintnr)

    # region name
    regionname = entryRegionName.get() # Holt die Daten aus der Eingabe, hier regionname.
    # Ist der Regionsname bereits vergeben dann Zahlen an den Regionsnamen anhaengen.
    if regionname =='' :
        regionname = randomname()
        regionnameout = regionname
    else:
        regionnameout = regionname + ' ' + str(mapintcounter)
        #counter += 1

    # Leerzeichen durch unterstriche austauschen denn leerzeichen sind im Dateinamen nicht erlaubt.
    confdatei = regionnameout.replace(" ", "_")

    # Konfiguration erstellen.
    config[regionnameout] = {'RegionUUID': ruuid,
                          'Location': maplocation,
                          'SizeX': Size_var,
                          'SizeY': Size_var,
                          'SizeZ': Size_var,
                          'InternalAddress': InternalAddress,
                          'InternalPort': InternalPort,
                          'AllowAlternatePorts': AllowAlternatePorts,
                          checkResolveAdressoff + 'ResolveAddress': ResolveAdress,
                          'ExternalHostName': ExternalHostName,
                          'MaxPrims': MaxPrims,
                          'MaxAgents': MaxAgents,
                          checkDefaultLandingoff + 'DefaultLanding': '<' + DefaultLanding + '>',
                          checkNonPhysicalPrimMaxoff + 'NonPhysicalPrimMax': NonPhysicalPrimMax,
                          checkPhysicalPrimMaxoff + 'PhysicalPrimMax': PhysicalPrimMax,
                          checkClampPrimSizeoff + 'ClampPrimSize': ClampPrimSize,
                          checkMaxPrimsPerUseroff + 'MaxPrimsPerUser': MaxPrimsPerUser,
                          checkScopeIDoff + 'ScopeID': ScopeID,
                          checkRegionTypeoff + 'RegionType': RegionType,
                          checkMaptileStaticUUIDoff + 'MaptileStaticUUID': MaptileStaticUUID,
                          checkMaptileStaticFileoff + 'MaptileStaticFile': MaptileStaticFile,
                          checkMasterAvatarFirstNameoff + 'MasterAvatarFirstName': MasterAvatarFirstName,
                          checkMasterAvatarLastNameoff + 'MasterAvatarLastName': MasterAvatarLastName,
                          checkMasterAvatarSandboxPasswordoff + 'MasterAvatarSandboxPassword': MasterAvatarSandboxPassword}

    with open(confdatei + '.ini', 'w') as configfile: config.write(configfile)

def createconfig():
    i=0
    n = int(entryRegionamount.get()) # Holt die Daten aus der Eingabe, hier die Menge der Regionen.

    for i in range(i, n):
	    write_region(mapintcounter = i, regionsintnr = n)
    else:
	    return mapintcounter, regionsintnr;

def clear_input_field():
   global counter, mapsprung, xcounter, ycounter
   counter = 0
   xcounter = 0
   ycounter = 0
   mapsprung = 0
   # Entry clear
   entryRegionName.delete(0, END)
   entryLocationx.delete(0, END)
   entryLocationy.delete(0, END)
   entryRegionUUID.delete(0, END)
   entrySize.delete(0, END)
   entryInternalPort.delete(0, END)
   entryAllowAlternatePorts.delete(0, END)
   entryResolveAdress.delete(0, END)
   entryExternalHostName.delete(0, END)
   entryMaxPrims.delete(0, END)
   entryMaxAgents.delete(0, END)
   entryDefaultLanding.delete(0, END)
   entryNonPhysicalPrimMax.delete(0, END)
   entryPhysicalPrimMax.delete(0, END)
   entryClampPrimSize.delete(0, END)
   entryMaxPrimsPerUser.delete(0, END)
   entryScopeID.delete(0, END)
   entryRegionType.delete(0, END)
   entryMaptileStaticUUID.delete(0, END)
   entryMaptileStaticFile.delete(0, END)
   entryMasterAvatarFirstName.delete(0, END)
   entryMasterAvatarLastName.delete(0, END)
   entryMasterAvatarSandboxPassword.delete(0, END)
   entryInternalAddress.delete(0, END)
   entryRegionamount.delete(0, END)
   entryRegionamount.insert(10, "1") # Mindestens eine Region erstellen.
   # Checkbox clear
   checkDefaultLanding.set(0)
   checkNonPhysicalPrimMax.set(0)
   checkPhysicalPrimMax.set(0)
   checkClampPrimSize.set(0)
   checkMaxPrimsPerUser.set(0)
   checkScopeID.set(0)
   checkRegionType.set(0)
   checkMaptileStaticUUID.set(0)
   checkMaptileStaticFile.set(0)
   checkResolveAdress.set(0)
   checkMasterAvatarFirstName.set(0)
   checkMasterAvatarLastName.set(0)
   checkMasterAvatarSandboxPassword.set(0)
