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
		$query = mysqli_query($dbc,"SELECT request_uid FROM `Friend Requests` WHERE requested_uid = '$uid' LIMIT 0, 50");

		$num_rows = mysqli_num_rows($query);

		for ($i = 0; $i < $num_rows; $i++){
			$row = mysqli_fetch_array($query, MYSQLI_NUM);
			$request_uid = $row[0];

			//echoing out request_uid

			if (!($i+1<$num_rows)){
				echo $request_uid;
			}
			else{
				echo $request_uid.":";
			}

		}


	}

?>