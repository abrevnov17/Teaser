d<?php
	//this is our php file to create a group

	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
		$member_uid = $_POST["member_uid"];
	
		//adding the group to the Groups database
		$query = mysqli_query($dbc,"INSERT INTO `Group Members` (group_uid, member_uid) VALUES ('$group_uid', '$member_uid')");

		if ($query){
			echo "success";
		}
		else {
			echo "Invalid name or number of members";
		}

	}

?>