#!/usr/bin/php
<?php
   class MyDB extends SQLite3 {
    function __construct() {
       $this->open('test.db');
    }
 }
//Creas una variable de tipo objeto mysqli con los datos de la bd y el charset que quieras
$mysqli = new mysqli('localhost', 'opensim', 'diego2', 'opensim');
// $mysqli = new SQLite3('test.db');
$mysqli->set_charset("utf8");
$res = $mysqli->query("SELECT * FROM auth");
$separator = "\n";

echo "==> AUTH\n";
while($f = $res->fetch_object()){
    echo "UUID: ". $f->UUID. $separator;
    echo "accountType: ". $f->accountType. $separator;
    echo "passwordHash: ". $f->passwordHash. $separator;
    echo "passwordSalt: ". $f->passwordSalt. $separator;
    echo "webLoginKey: ". $f->webLoginKey. $separator;
}

echo "==> USERACCOUNTS\n";
$res = $mysqli->query("SELECT * FROM useraccounts");
while($f = $res->fetch_object()){
    echo "FirstName: ". $f->FirstName. $separator;
    echo "LastName: ". $f->LastName. $separator;
    echo "PrincipalID: ". $f->PrincipalID. $separator;
}

echo "==>TABLES \n";
$res = $mysqli->query("show tables");
while($f = $res->fetch_array()) { echo $f[0]. $separator; }
$mysqli->close();

$mysqli = new mysqli('localhost', 'opensim', 'diego77', 'opensim');
// $mysqli = new SQLite3('test.db');
$mysqli->set_charset("utf8");
echo "==> REGIONS\n";
$res1 = $mysqli->query("SELECT * FROM regions") or error("test");
echo is_numeric($res);
while($f = $res1->fetch_array()) { echo $f. $separator; }

while($f = $res->fetch_object()){
    echo "uuid: ". $f->uuid. $separator;
    echo "regionHandle: ". $f->regionHandle. $separator;
    echo "regionName: ". $f->regionName. $separator;
    echo "regionSendKey: ". $f->regionSendKey. $separator;
    echo "regionSecret: ". $f->regionSecret. $separator;
    echo "regionDataURI: ". $f->regionDataURI. $separator;
    echo "serverIP: ". $f->serverIP. $separator;
    echo "serverPort: ". $f->serverPort. $separator;
    echo "serverURI: ". $f->serverURI. $separator;
    echo "locX: ". $f->locX. $separator;
    echo "locY: ". $f->locY. $separator;
    echo "locZ: ". $f->locZ. $separator;
    echo "sizeX: ". $f->sizeX. $separator;
    echo "sizeY: ". $f->sizeY. $separator;
    echo "flags: ". $f->flags. $separator;
}
?>