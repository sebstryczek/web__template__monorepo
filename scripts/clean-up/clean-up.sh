#!/bin/bash

echo "Removing node_modules directories...";
rm -rf node_modules */**/node_modules
echo "Done.";

echo "Removing package-lock.json files...";
rm -rf package-lock.json */**/package-lock.json
echo "Done.";

echo "Removing dist directories...";
rm -rf dist */**/dist
echo "Done.";

echo "Removing declarations directories...";
rm -rf declarations */**/declarations
echo "Done.";

echo "Removing turbo directories...";
rm -rf .turbo */**/.turbo
echo "Done.";
