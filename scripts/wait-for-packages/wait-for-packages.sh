#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <package-name-1> <package-name-2> ... <package-name-n>"
  exit 1
fi

WAITING_INTERVAL_IN_SECONDS=2

PACKAGES_DIR="../../packages"
PACKAGES_PARTIALS_DIR="../../packages-partials"
PACKAGES_DIRS=($PACKAGES_DIR $PACKAGES_PARTIALS_DIR)

for PACKAGE_NAME in "$@"; do
  for PACKAGE_DIR in ${PACKAGES_DIRS[@]}; do
    PACKAGE_PATH="$PACKAGE_DIR/$PACKAGE_NAME/package.json"
    if [ -f "$PACKAGE_PATH" ]; then
      echo "Found package at $PACKAGE_PATH"\

      EXPORTS=$(node -e "
        const fs = require('fs');
        const packagePath = '$PACKAGE_PATH';
        const packageJson = JSON.parse(fs.readFileSync(packagePath, 'utf8'));

        const exports = packageJson.exports;
        const paths = Object.values(exports).flatMap((value) => {
          return Object.values(value);
        });

        console.log(paths.join(','));
      ")

      IFS=',' read -r -a EXPORTS_ARRAY <<< "$EXPORTS"

      for EXPORT in ${EXPORTS_ARRAY[@]}; do
        while true; do
          if [ -f "$PACKAGE_DIR/$PACKAGE_NAME/$EXPORT" ]; then
            # echo "$PACKAGE_DIR/$PACKAGE_NAME/$EXPORT is ready!"
            break
          else
            echo "Waiting for '$PACKAGE_NAME' ..."

            # check if is xterra-workers
            if [ "$PACKAGE_NAME" == "xterra-workers" ]; then
              echo "Waiting for xterra-workers ..."
              echo $EXPORTS
              sleep $WAITING_INTERVAL_IN_SECONDS
            fi

            sleep $WAITING_INTERVAL_IN_SECONDS
          fi
        done
      done
    # else
    #   echo "$PACKAGE_DIR/$PACKAGE_NAME is not a package."
    fi
  done
done

echo "All packages are ready!"
