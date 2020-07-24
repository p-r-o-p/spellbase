<?php

require_once 'vendor/autoload.php';

use Medoo\Medoo;

$db = new Medoo([
    'database_type' => 'mysql',
    'database_name' => getenv('MYSQL_DATABASE'),
    'server' => getenv('MYSQL_HOST'),
    'username' => getenv('MYSQL_USER'),
    'password' => getenv('MYSQL_PASSWORD'),
    'logging' => true,
]);

$db->create("account", [
    "id" => [
        "INT",
        "NOT NULL",
        "AUTO_INCREMENT",
        "PRIMARY KEY",
    ],
    "user_name" => [
        "VARCHAR(30)",
        "NOT NULL",
        "UNIQUE",
    ],
    "email" => [
        "VARCHAR(255)",
        "NOT NULL",
        "UNIQUE",
    ]
]);

$db->insert('account', [
    'user_name' => 'foo',
    'email' => 'foo@bar.com',
]);

$data = $db->select('account', [
    'user_name',
    'email',
]);

echo json_encode($data);
