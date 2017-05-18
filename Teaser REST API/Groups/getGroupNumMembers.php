<?php
	
	//this is our getGroupNumMembers function. it takes in a group_uid and returns the number of members of the given group

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT number_of_members FROM Groups WHERE group_uid = '$group_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$number_of_members = $row[0];

		//echoing out the number of members in the group

		echo $number_of_members;

		}

	
?>