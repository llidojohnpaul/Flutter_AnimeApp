<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
    $response = array();

    $email = $_POST['email'];
    $password = $_POST['password'];
 

    $check = "SELECT * FROM users WHERE email='$email' and password='$password'";
    $result = mysqli_fetch_array(mysqli_query($con,$check));

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = "Login Successfully";
        $response['name'] = $result['name'];
        $response['email'] = $result['email'];
        $response['userid'] = $result['userid'];
        
        echo json_encode($response);
        
    }
    else
    {
        $response['value'] = 0;
        $response['message'] = "Login Failed";
        echo json_encode($response);
    }

    

   
}

?>