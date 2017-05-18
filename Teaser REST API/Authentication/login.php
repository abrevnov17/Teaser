<?php
	
	//this is our login function. it takes in some post data and logs in a user

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established -> now we attempt to login a user from inputted data

		//setting variable values from POST

		$username = $_POST["username"];
		$password = $_POST["password"];
	
		//querying data based on information
		$query = mysqli_query($dbc,"SELECT uid FROM Accounts WHERE username = '$username' AND password = '$password' LIMIT 0, 1");
		$row = mysqli_fetch_array($query, MYSQLI_NUM);

		//check if success
  		if ($query)
  		{
			echo "success:".$row[0];		
		}

  		else
  		{
  			echo "Incorrect login information";
  		}



	}




?>