d<?php
	//this is our php file to get the UID of the last inserted object

	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		$query = mysqli_query($dbc,"SELECT LAST_INSERT_ID();");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$group_uid = $row[0];

		if ($query){
			echo $group_uid;
		}
		else {
			echo "failure";
		}

	}

?>