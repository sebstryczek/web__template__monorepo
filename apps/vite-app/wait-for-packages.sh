#!/bin/bash

PACKAGES_DIR="../../packages"

for PACKAGE_DIR in $PACKAGES_DIR/xterra-*; do
  while true; do
    if ls $PACKAGE_DIR/dist/index.*.js 1> /dev/null 2>&1; then
      echo "$PACKAGE_DIR is ready!"
      break
    else
      sleep 1
    fi
  done
done

echo "All packages are ready!"
