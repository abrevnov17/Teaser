<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$uid= $_POST["uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT username FROM Accounts WHERE uid = '$uid' LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$username= $row[0];

		echo $username;


	}

?>