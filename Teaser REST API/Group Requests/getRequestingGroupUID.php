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
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT requesting_group_uid FROM `Group Members` WHERE request_uid = '$request_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$requesting_group_uid= $row[0];

		echo $requesting_group_uid;


	}

?>