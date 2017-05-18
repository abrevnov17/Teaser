<?php
	
	//this is our getGroupName function. it takes in a group_uid and returns the string name of the group

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT group_name FROM Groups WHERE group_uid = '$group_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$group_name = $row[0];

		//echoing out the group_name

		echo $group_name;

		}

?>