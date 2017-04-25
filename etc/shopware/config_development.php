<?php
$additionalConfiguration = require 'config.php';

$additionalConfiguration = array_replace_recursive($defaultConfig, [
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
]);

$configurationFiles = glob(__DIR__ . '/conf.d/*.php');
foreach ($configurationFiles as $file) {
    $additionalConfiguration = array_replace_recursive($additionalConfiguration, require($file));
}

return $additionalConfiguration;
