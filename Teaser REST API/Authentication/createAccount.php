<?php
	
	//this is our create account function. it takes in some post data and adds a new user to our backend

	$dbc= mysqli_connect("localhost", "abrevnov17", "abrevnov171234", "abrevnov17");
	if(!$dbc){ // there was an error connecting
		echo "Failed to connect to the database.  Error=".mysqli_connect_error();
	}
	else {
		//mysql connection has been established -> now we attempt to create a user from inputted data

		//setting variable values from POST

		$username = $_POST["username"];
		$email = $_POST["email"];
		$password = $_POST["password"];	

		//need to verify that username does not already exist
		$query = mysqli_query($dbc,"SELECT username FROM Accounts WHERE username='$username'");

  		if (mysqli_num_rows($query) != 0)
  		{
			echo "Username already exists";
  		}

  		else
  		{
  			//inserting new user into Users table
  			$sql = "INSERT INTO Accounts (username,email,password) VALUES ('$username','$email','$password')";
			mysqli_query($dbc,$sql);
			echo 'success';
			


  		}



	}




?>