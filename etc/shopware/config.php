<?php

return [
    'db' => [
        'host' => getenv('MACB2B_MYSQL_1_ENV_MYSQL_HOSTNAME'),
        'port' => getenv('MACB2B_MYSQL_1_ENV_MYSQL_PORT'),
        'username' => getenv('MACB2B_MYSQL_1_ENV_MYSQL_USER'),
        'password' => getenv('MACB2B_MYSQL_1_ENV_MYSQL_PASSWORD'),
        'dbname' => getenv('MACB2B_MYSQL_1_ENV_MYSQL_DATABASE'),
    ],
    'es' => [
        'enabled' => true,
        'client' => [
            'hosts' => [
                getenv('ELASTIC_HOST') . ':' . getenv('ELASTIC_PORT')
            ]
        ]
    ],
];