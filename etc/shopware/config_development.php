<?php
$defaultConfig = require 'config.php';

return [
    'db' => $defaultConfig['db'],
    'es' => $defaultConfig['es'],

    'errorHandler' => [
        'throwOnRecoverableError' => true,
    ],

    'csrfProtection' => [
        'frontend' => false,
        'backend' => false
    ],
    
    'front' => [
        'throwExceptions' => true,
        'showException' => true,
        'noErrorHandler' => false,
    ],

    'phpsettings' => [
        'display_errors' => 1,
    ],

    'model' => [
        'cacheProvider' => 'array'
    ],
];
