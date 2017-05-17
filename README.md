# Docker - Shopware 5.2

Based on the [php-docker-boilerplate](https://github.com/webdevops/php-docker-boilerplate) we create a pre-built docker image on which you can build your environment.

Image contains:

 - Ubuntu 16.04
 - PHP7 (including ionCube)
 - Nginx (with shopware optimized configuration)
 - Tag for recent shopware versions (5.2 branch only)

Use an image like e.g.:

	1drop/shopware:5.2.12

Or the dev image which includes XDebug, PHPUnit and many more

## ENV variables

Special ENV variables have been introduced to configure shopware via docker.

| ENV             | Description                        | Example       |
|-----------------|------------------------------------|---------------|
| MYSQL_HOSTNAME  | Hostname or IP to connect to mysql | database.host |
| MYSQL_PORT      | Port to connect to mysql           | 3306          |
| MYSQL_USER      | Username                           | dbuser        |
| MYSQL_PASSWORD  | Password                           | dbpass        |
| MYSQL_DATABASE  | Database                           | shopware      |
| ELASTIC_ENABLED | Enable elasticsearch               | true          |
| ELASTIC_HOST    | Hostname or IP to connect to es    | elastic.host  |
| ELASTIC_PORT    | Port to connect to elasticsearch   | 9200          |


## Additional configuration

Mount a folder to `/app/conf.d/` and place any PHP script in the form of

	<?php
	return [
		'errorHandler' => [
        	'throwOnRecoverableError' => true,
    	],
	];

inside the `conf.d` folder. This configuration will overrule all previous set
configuration parts of the configuration array (uses `array_replace_recursive` internally).
