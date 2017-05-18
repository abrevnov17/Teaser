<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$uid = $_POST["uid"];
	
		//querying data based on information

		//here we will need to do two queries for each column that uid could be in
		$query = mysqli_query($dbc,"SELECT user_uid_one FROM Friends WHERE user_uid_two= '$uid' LIMIT 0, 100");
		$query2 = mysqli_query($dbc,"SELECT user_uid_two FROM Friends WHERE user_uid_one= '$uid' LIMIT 0, 100");

		$num_rows = mysqli_num_rows($query);

		for ($i = 0; $i < $num_rows; $i++){
			$row = mysqli_fetch_array($query, MYSQLI_NUM);
			$user_uid_one = $row[0];

			echo $user_uid_one.":";

		}

		$num_rows = mysqli_num_rows($query2);

		for ($i = 0; $i < $num_rows; $i++){
			$row = mysqli_fetch_array($query2, MYSQLI_NUM);
			$user_uid_two= $row[0];

			echo $user_uid_two.":";

		}

		}

?>