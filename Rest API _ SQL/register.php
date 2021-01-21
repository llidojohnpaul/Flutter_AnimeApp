<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){

    $response = array();
    $email = $_POST['email'];
    $password = $_POST['password'];
    $name = $_POST['name'];


    
    $check = "SELECT * FROM users WHERE email='$email'";
    $result = mysqli_fetch_array(mysqli_query($con,$check));

    if (isset($result)) 
    {
        $response['value']=2;
        $response['message'] = "Email already exist";
        echo json_encode($response);
    } 
    else
    {
        $insert = "INSERT INTO users VALUE(NULL,'$email','$password','$name')";
        if (mysqli_query($con,$insert))
        {
            $response['value'] = 1;
            $response['message'] = "Registered Successfully";
            echo json_encode($response);
        }
        else
        {
            $response['value'] = 0;
            $response['message'] = "Registration Failed";
            echo json_encode($response);
        }
     
    }
    

  
   
 
}

?>