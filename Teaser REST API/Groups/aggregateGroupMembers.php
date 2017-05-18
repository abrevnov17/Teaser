<?php
	
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT member_uid FROM `Group Members` WHERE group_uid = '$group_uid' LIMIT 0, 31");

		$num_rows = mysqli_num_rows($query);

		for ($i = 0; $i < $num_rows; $i++){
			$row = mysqli_fetch_array($query, MYSQLI_NUM);
			$member_uid = $row[0];

			//echoing out the group members

			if (!($i+1<$num_rows)){
				echo $member_uid;
			}
			else{
				echo $member_uid.":";
			}

		}

	}

?>