<?php
	
	//this is our aggregateGroups function. it takes in some post data and returns all of the 

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established -> now we attempt to login a user from inputted data

		//setting variable values from POST

		$member_uid = $_POST["member_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT group_uid FROM `Group Members`  WHERE member_uid = '$member_uid' LIMIT 0, 50");

		$num_rows = mysqli_num_rows($query);

		for ($i = 0; $i < $num_rows; $i++){
			$row = mysqli_fetch_array($query, MYSQLI_NUM);
			$group_uid = $row[0];

			//echoing out the group_uid

			if (!($i+1<$num_rows)){
				echo $group_uid;
			}
			else{
				echo $group_uid.":";
			}

		}
	

	}

?>