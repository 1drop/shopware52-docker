<?php

$additionalConfiguration = [
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

$configurationFiles = glob(__DIR__ . '/conf.d/*.php');
foreach ($configurationFiles as $file) {
    $additionalConfiguration = array_replace_recursive($additionalConfiguration, require($file));
}

return $additionalConfiguration;
