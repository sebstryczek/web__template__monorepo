#!/bin/bash

PACKAGES_DIR="../../packages"
PACKAGES_PREFIX="xterra-"

echo "Waiting for packages..."

for PACKAGE_DIR in $PACKAGES_DIR/$PACKAGES_PREFIX*; do
  if [ -f "$PACKAGE_DIR/package.json" ]; then
    while true; do
      if ls $PACKAGE_DIR/dist/index.*.js 1> /dev/null 2>&1; then
        echo "$PACKAGE_DIR is ready!"
        break
      else
        echo "Waiting for $PACKAGE_DIR..."
        sleep 1
      fi
    done
  else
    echo "$PACKAGE_DIR is not a package."
  fi
done

echo "All packages are ready!"
