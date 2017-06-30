<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$request_uid= $_POST["request_uid"];
		$uid = $_POST["uid"];
	
		//querying data based on information to ge the requesting friend uid which we will use to create a friendship
		$query = mysqli_query($dbc,"SELECT requesting_uid FROM `Friend Requests` WHERE request_uid = '$request_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$requesting_uid= $row[0];

		//creating a user/friend friendship relationship by inserting a row into the Friends table

		$query = mysqli_query($dbc,"INSERT INTO `Friends` (user_uid_one, user_uid_two) VALUES ('$uid','$requesting_uid'");

		if ($query){

			echo "success";
		}

		else {

			echo "failure";
		}

	}

?>