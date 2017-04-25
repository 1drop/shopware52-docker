<?php

/*
 *      To speed up the build process using travis matrix combinations
 *      we introduce the convention that PHP 7.0 produces dev builds and 7.1
 *      produces production builds (as docker building is independant from CI CLI).
 */

$isDev = isset($argv[1]) && $argv[1] === 'dev';
$shopwareVersion = getenv('SHOPWARE_VERSION');

if ($isDev) {
    $dockerfile = file_get_contents('Dockerfile.dev.tpl');
} else {
    $dockerfile = file_get_contents('Dockerfile.prod.tpl');
}

$dockerfile = str_replace('{{SHOPWARE_VERSION}}', $shopwareVersion, $dockerfile);
file_put_contents('Dockerfile', $dockerfile);
