<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
   
    $response = array();
    $name = $_POST['name'];
    $artist = $_POST['artist'];
    $price = $_POST['price'];
    $clientid = $_POST['clientid'];
    


    $insert = "UPDATE anime SET name ='$name', artist = '$artist', price = '$price' WHERE id='$clientid'";
    if (mysqli_query($con,$insert))
    {
        $response['value'] = 1;
        $response['message'] = "Record Successfully";
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