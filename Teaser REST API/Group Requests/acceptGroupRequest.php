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
	
		//querying data based on information to ge the requesting group uid which we will use to add the user to that group
		$query = mysqli_query($dbc,"SELECT requesting_group_uid FROM `Group Requests` WHERE request_uid = '$request_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$requesting_group_uid= $row[0];

		//adding the user to the group

		$query = mysqli_query($dbc,"INSERT INTO `Group Members` (group_uid, member_uid) VALUES ('$requesting_group_uid','$uid'");

		if ($query){

			echo "success";
		}

		else {

			echo "failure";
		}

		//adding one to the number of members in the given group

		$query = mysqli_query($dbc,"UPDATE Groups SET `number_of_members` = `number_of_members` + 1 WHERE group_uid='$requesting_group_uid'");



	}

?>