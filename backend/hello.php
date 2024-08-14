<?php
header("Access-Control-Allow-Origin: *"); // Allow requests from any origin
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS"); // Allow specific HTTP methods
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Allow specific headers

header('Content-Type: application/json');

// Simple JSON response
$response = ['message' => 'Hello from the PHP backend!'];
echo json_encode($response);
?>
