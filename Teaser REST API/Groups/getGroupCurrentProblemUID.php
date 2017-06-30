<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT current_problem_uid FROM Groups WHERE group_uid = '$group_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$current_problem_uid = $row[0];

		echo $current_problem_uid;

		

	}

?>