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

		$group_name= $_POST["group_name"];
		$number_of_members = $_POST["number_of_members"];
		$description = $_POST["description"];
		$admin_uid = $_POST["admin_uid"];
	
		//adding the group to the Groups database
		$query = mysqli_query($dbc,"INSERT INTO `Groups` (group_name, number_of_members, description, admin_uid) VALUES ('$group_name', '$number_of_members', '$description', '$admin_uid')");

		//we also need to return the group uid which we need in our wrapper to immediately add members to the group
		$query = mysqli_query($dbc,"SELECT LAST_INSERT_ID();");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$group_uid = $row[0];

		if ($query){
			echo "success:".$group_uid;
		}
		else {
			echo "Invalid name or number of members";
		}

	}

?>