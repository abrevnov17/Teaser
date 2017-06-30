<?php
	
	//logging into mysql

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established

		//setting variable values from POST

		$group_uid = $_POST["group_uid"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"UPDATE Groups SET current_problem_timestamp = NOW() WHERE group_uid = '$group_uid'");

		if ($query){

			echo "success";
		}

		else {

			echo "failure";
		}

	}

?>