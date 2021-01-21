<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
  
   // $data = json_decode(file_get_contents('php://input'), true);
    $response = array();
    $name = $_POST['name'];
    $artist = $_POST['artist'];
    $price = $_POST['price'];
    $clientid = $_POST['clientid'];



    $insert ="INSERT INTO anime VALUE(NULL,'$name','$artist','$price','$clientid')";
    if (mysqli_query($con,$insert))
    {
        $response['value'] = 1;
        $response['message'] = "Record Successfully Added";
        echo json_encode($response);
    }
    else
    {
        $response['value'] = 0;
        $response['message'] = "Record Failed";
        echo json_encode($response);
    }
     
    
    

  
   
 
}

?>