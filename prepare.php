<?php

$isDev = getenv('IS_DEV');
if ($isDev) {
    $dockerfile = file_get_contents('Dockerfile.dev.tpl');
} else {
    $dockerfile = file_get_contents('Dockerfile.prod.tpl');
}

$opts = ['http' => ['method' => 'GET', 'header' => ['User-Agent: PHP']]];
$context = stream_context_create($opts);
$shopwareTags = json_decode(file_get_contents('https://api.github.com/repos/shopware/shopware/tags', false, $context), true);

foreach ($shopwareTags as $shopwareTag) {
    $tag = $shopwareTag['name'];
    // Ignore version tags like -RC etc.
    if (preg_match('/v(\d+\.\d+\.\d+)$/', $tag, $m)) {
        $shopwareVersion = $m[1];
        $dockerfile = str_replace('{{SHOPWARE_VERSION}}', $shopwareVersion, $dockerfile);
        file_put_contents('Dockerfile', $dockerfile);
        $image = '1drop/shopware:' . $shopwareVersion;
        $image = ($isDev) ? $image . '-dev' : $image;
        echo 'BUILDING IMAGE: ' . $image . PHP_EOL;
        system('docker build -f Dockerfile -t 1drop/shopware:' . $shopwareVersion . ' .');
        system('docker push 1drop/shopware:' . $shopwareVersion);
    }
}
