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

		$query = mysqli_query($dbc,"SELECT member_score FROM `Group Members` where membership_uid = '$membership_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$member_score = $row[0];

		//echoing out the member_score

		echo $member_score;

	}

?>