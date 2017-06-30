<?php
	
	//connecting to database
	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {

		//mysql connection has been established

		//setting variable values from POST

		$request_uid= $_POST["request_uid"];
	
		//deleting row from Friend Requests table where the request_uid field matches our inputted request_uid
		$query = mysqli_query($dbc,"DELETE FROM `Friend Requests` WHERE request_uid = '$request_uid'");

		if ($query){

			echo "success";
		}

		else {

			echo "failure";
		}


	}

?>