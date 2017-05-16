#!/bin/bash

RELEASES=$(curl -s https://api.github.com/repos/shopware/shopware/tags | jq '.[] | .name')

for release in "${RELEASES[@]}"; do
  echo $release
done