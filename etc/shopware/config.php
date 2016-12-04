<?php

return [
    'db' => [
        'host' => getenv('MYSQL_HOSTNAME'),
        'port' => getenv('MYSQL_PORT'),
        'username' => getenv('MYSQL_USER'),
        'password' => getenv('MYSQL_PASSWORD'),
        'dbname' => getenv('MYSQL_DATABASE'),
    ],
    'es' => [
        'enabled' => getenv('ELASTIC_ENABLED') ? true : false,
        'client' => [
            'hosts' => [
                getenv('ELASTIC_HOST') . ':' . getenv('ELASTIC_PORT')
            ]
        ]
    ],
];