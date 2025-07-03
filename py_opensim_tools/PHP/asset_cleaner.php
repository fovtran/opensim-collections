#!/usr/bin/php
<?php
 
/////////////////////////////////////////////////////////////
// Wizardry and Steamworks (c) grimore.org - 2013, License: MIT //      
//                                                         //
// Permission is hereby granted, free of charge, to any    //
// person obtaining a copy of this software and associated //
// documentation files (the "Software"), to deal in the    //
// Software without restriction, //including without       //
// limitation the rights to use, copy, modify, merge,      //
// publish, distribute, sublicense, and/or sell copies of  //
// the Software, and to permit persons to whom the         //
// Software is furnished to do so, subject to the          //
// following conditions:                                   //
//                                                         //
// The above copyright notice and this permission notice   //
// shall be included in all copies or substantial portions //
// of the Software.                                        //
//                                                         //
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF   //
// ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT         //
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS   //
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO     //
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE  //
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER      //
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    //
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR      //
// THE USE OR OTHER DEALINGS IN THE SOFTWARE.              //
/////////////////////////////////////////////////////////////
 
/////////////////////////////////////////////////////////////
//                    CONFIGURATION                        //
/////////////////////////////////////////////////////////////
 
// Hostname or IP of your OpenSim MySQL server.
define("MYSQL_HOSTNAME", "localhost");
// Username of the OpenSim MySQL user.
define("MYSQL_USERNAME", "opensim");
// Password of the OpenSim MySQL user.
define("MYSQL_PASSWORD", "diego2");
// Name of the OpenSim database on the MySQL server.
define("MYSQL_DATABASE", "opensim");
 
/////////////////////////////////////////////////////////////
//                     INTERNALS                           //
/////////////////////////////////////////////////////////////
 
if(!defined('STDIN')) {
    print 'This script is meant to be run on the command line.'."\n";
    return 1;
}
if($argc < 2) {
    print 'ERROR: Please specify OARs and IARs to filter on the command line.'."\n";
    print 'Syntax: php '.$argv[0]. ' <OAR|IAR|...>'."\n";
    return 1;
}
 
/*
* Connect to the database and grab all the texture UUIDs
* and store them in an array for later filtering.
*/
$connection_ok = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD);
if(!$connection_ok) {
    print 'Could not connect to the OpenSim database. Please edit the script and make sure the credentials are correct.'."\n";
    return 1;
}
$db_selected = mysql_select_db(MYSQL_DATABASE);
if(!$db_selected) {
    print 'Could not select the opensim database. Please edit this script and make sure the credentials are correct.'."\n";
    return 1;
}
// Now we can get rid of the script name.
array_shift($argv);
 
/* 
 * First thing to do is search all scripts for references to assets. This will ensure that assets 
 * that are referenced inside scripts and that are deleted from an avatar's inventory or not 
 * displayed in-world will not be deleted from the database.
 */ 
$scriptReferences = array();
foreach($argv as $arg) {
    if(!file_exists($arg)) {
        print 'Archive: '.$arg.' does not exist.'."\n";
        return 1;
    }
    $files = array();
    exec('tar -tzf '.$arg.' 2>/dev/null', $files, $ret);
    foreach($files as $file) {
        if(!preg_match('/_script/i', $file)) continue;
        $data = array();
        exec('tar -zf '.$arg.' -xO '.$file.' 2>/dev/null', $data, $ret);
        if($ret != 0) {
            print 'Could not process script: '.$file."\n";
            return 1;
        }
        preg_match_all("/([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})/i", implode($data), $referencesInScripts);
        foreach($referencesInScripts[1] as $uuid) {
            array_push($scriptReferences, $uuid);
        }
    }
}
 
/*
 * Now start cleaning assets.
 */
$assets = array( "texture" => 0, "sound" => 1, "clothing" => 5, "script" => 10, "bodypart" => 13, "animation" => 20 );
foreach($assets as $assetName => $assetValue) {
    $query = 'SELECT * FROM assets WHERE assetType='.$assetValue;
    $result = mysql_query($query);
 
    $allAssets = array();
    while($row = mysql_fetch_array($result)) {
        array_push($allAssets, $row['id']);
    }
 
    /*
    * Now grab all the texture UUIDs from the OARs and IARs
    * supplied on the command line for an exclusion list.
    */
    $liveAssets = array();
    foreach($argv as $arg) {
        if(!file_exists($arg)) {
            print 'Archive: '.$arg.' does not exist.'."\n";
            return 1;
        }
        $files = array();
        exec('tar -tzf '.$arg.' 2>/dev/null', $files, $ret);
        if($ret != 0) {
            print 'Could not process archive: '.$arg."\n";
            return 1;
        }
        preg_match_all("/([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})_$assetName/i", implode($files), $dumpAssets);
        foreach($dumpAssets[1] as $uuid) {
            array_push($liveAssets, $uuid);
        }
    }
    // Now add the script references to the pool.
    array_push($liveAssets, $scriptReferences);
 
    /*
    * We consider all the assets in the OARs and IARs 
    * supplied on the command line to be live assets.
    * Everything else is considered unreferenced and 
    * orphaned.
    *
    * ORPHANED_ASSETS = (ALL_ASSETS \ LIVE_ASSETS) \ SCRIPT_REFERENCES_TO_ASSETS
    *
    * The same applies to all other asset types.
    */
    $orphanedAssets = array_values(array_diff($allAssets, $liveAssets));
    if(sizeof($orphanedAssets) == 0) {
        print 'Congratulations! Your OpenSim database contains no unreferenced '.$assetName."s.\n";
        continue;
    }
 
    /*
     * List assets to be deleted.
     */
    print '-------------------- REMOVE -----------------'."\n";
    foreach($orphanedAssets as $asset) {
        $query = 'SELECT * FROM assets WHERE assetType='.$assetValue.' AND id=\''.$asset.'\'';
        $result = mysql_query($query);
        while($row = mysql_fetch_array($result)) {
            print $row['name'].' '.$asset."\n";
        }
    }
    print '---------------------------------------------'."\n";
 
    /*
    * Perform some minor liability dumping. Last chance to quit.
    */
    ASK:   
    print sizeof($orphanedAssets).' '.$assetName.'s will be removed from the database. Are you sure? (y/n) : ';
    $in=trim(fgets(STDIN));
    if($in == 'y') goto GO;
    if($in == 'n') {
        print 'Bailing out. Nothing was deleted.'."\n";
        continue;
    }
    print 'Please type either y to proceed or n to quit without deleting anything.'."\n";
    goto ASK;
 
    /*
    * Start to delete unreferenced assets from the database.
    */
    GO:
    foreach($orphanedAssets as $uuid) {
        $query = 'DELETE FROM assets WHERE assetType='.$assetValue.' AND id=\''.$uuid.'\'';
        $result = mysql_query($query);
        if($result) {
            print '-';
            continue;
        }
        print 'e';
    }
 
    print "\n";
    print 'Finished deleting '.$assetName."s.\n";
}
 
print "\n";
print 'All operations completed!'."\n";
 
?>