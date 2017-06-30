<?php
	//this is our php file to create a group

	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$membership_uid = $_POST["membership_uid"];

		$query = mysqli_query($dbc,"SELECT last_answered_timestamp FROM `Group Members` where membership_uid = '$membership_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$last_answered_timestamp = $row[0];

		//echoing out the last_answered_timestamp

		echo $last_answered_timestamp;

	}

?>