<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$uid = $_POST["user_uid"];
		$difficulty = $_POST["difficulty"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT problem_uid FROM Problems WHERE difficulty = '$difficulty' ORDER BY RAND() LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$problem_uid= $row[0];

		echo $problem_uid;


	}

?>