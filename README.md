# Docker - Shopware 5.2 GIT latest

Based on the [php-docker-boilerplate](https://github.com/webdevops/php-docker-boilerplate) we create a pre-built docker image on which you can build your environment.

Image contains:

 - Ubuntu 16.04
 - PHP7 (=> no ioncube!!!)
 - Nginx (with shopware optimized configuration)
 - Latest shopware git branch 5.2

From this repository we build three different images:

	1drop/shopware-52:test
	1drop/shopware-52:debug
	1drop/shopware-52:prod

## 1drop/shopware-52:prod

This image is for production usage and contains only the most needed software.  
Install/Recovery doesn't work!

## 1drop/shopware-52:test

This image additionally contains `ant, phpunit, phpcs` so you can run tests and use the shopware build tools.

## 1drop/shopware-52:debug

This image is based on `webdevops/php-nginx-dev:ubuntu-16.04` and therefore contains xdebug, blackfire and other stuff needed for debugging.


## Future improvements

- Install profiling tools for debug (Profiler, Clockwork)
- Include configuration respecting ENV variables (and document them)
