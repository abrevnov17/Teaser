<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$user_uid = $_POST["user_uid"];
		$problem_uid = $_POST["problem_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT problem_type FROM Problems WHERE problem_uid = '$problem_uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$problem_type= $row[0];

		echo $problem_type;


	}

?>