<?php
$servername = "localhost";
$username = "diego2";
$password = "diego2";
$dbname = "opensim";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); }

$sql = "SELECT * FROM `useraccounts`";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "ID: ". $row["PrincipalID"]. "\t Name: " . $row["FirstName"]. " " . $row["LastName"]. "\n";
  }
} else { echo "0 results"; }

$sql = "SELECT * FROM `regions`";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "uuid: ". $row["uuid"]. "\t regionName: " . $row["regionName"]. "\n";
  }
} else { echo "0 results"; }
$conn->close();
?>