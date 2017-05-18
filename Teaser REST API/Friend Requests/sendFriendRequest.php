<?php
	//this is our php file to create a friend request

	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$username= $_POST["username"];
		$requesting_uid = $_POST["uid"];

		//query to get the requested_uid from the username
		$query = mysqli_query($dbc,"SELECT uid FROM `Accounts` WHERE username = '$username' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$requested_uid= $row[0];
	
		//adding the request to Friend Requests database
		$query = mysqli_query($dbc,"INSERT INTO `Friend Requests` (requesting_uid, requested_uid) VALUES ('$requesting_uid', '$requested_uid')");

		if ($query){
			echo "success";
		}
		else {
			echo "Invalid username";
		}

	}

?>