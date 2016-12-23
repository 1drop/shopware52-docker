# Docker - Shopware 5.2

Based on the [php-docker-boilerplate](https://github.com/webdevops/php-docker-boilerplate) we create a pre-built docker image on which you can build your environment.

Image contains:

 - Ubuntu 16.04
 - PHP7 (including ionCube)
 - Nginx (with shopware optimized configuration)
 - Tag for recent shopware versions (5.2 branch only)
 - latest 5.2-git revision (built on commit to shopware/shopware)

Use an image like e.g.:

	1drop/shopware-52:5.2.12

Or the latest git build:

	1drop/shopware-52:latest

## Future improvements

- Install profiling tools for debug (Profiler, Clockwork)
- Include configuration respecting ENV variables (and document them)
