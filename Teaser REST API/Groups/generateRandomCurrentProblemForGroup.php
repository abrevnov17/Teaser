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

		//first we need to query to get a random problem from our problems table
		$query = mysqli_query($dbc,"SELECT problem_uid FROM Problems ORDER BY RAND() LIMIT 0, 1");

		$row = mysqli_fetch_array($query, MYSQLI_NUM);
		$problem_uid= $row[0];

		//now that we have our problem_uid, we just have to update our group 
		$query = mysqli_query($dbc,"UPDATE Groups SET current_problem_uid = '$problem_uid' WHERE group_uid = '$group_uid'");

		if ($query){
			echo "success";
		}
		else {
			echo "failure";
		}

		

	}

?>