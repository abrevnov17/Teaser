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

		$uid = $_POST["uid"];
		$group_uid = $_POST["group_uid"];

		$query = mysqli_query($dbc,"SELECT membership_uid FROM `Group Members` where member_uid = '$uid' AND group_uid = '$group_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$membership_uid = $row[0];

		//echoing out the membership_uid

		echo $membership_uid;

	}

?>