#!/usr/bin/env bash

# Get the current version name from the .env file
echo "Getting current version name from .env"
APP_NAME=$(grep APP_NAME .env | cut -d '=' -f2)
MAJOR_VERSION=$(grep MAJOR_VERSION .env | cut -d '=' -f2)
MINOR_VERSION=$(grep MINOR_VERSION .env | cut -d '=' -f2)
PATCH_VERSION=$(grep PATCH_VERSION .env | cut -d '=' -f2)
PRE_RELEASE=$(grep PRE_RELEASE .env | cut -d '=' -f2)
echo ""

# Make a copy of .env
echo "Updating $APP_NAME version in .env"
echo " - Version Name : $MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION-$PRE_RELEASE"
echo ""

# Ask for the version type to update (major, minor, patch, pre-release)
echo "What version type would you like to update?"
echo "1. Major"
echo "2. Minor"
echo "3. Patch"
echo "4. Pre-Release"

read -p "Enter a number: " VERSION_TYPE

# Update the version name based on the version type
case $VERSION_TYPE in
    1)
        MAJOR_VERSION=$((MAJOR_VERSION+1))
        ;;
    2)
        MINOR_VERSION=$((MINOR_VERSION+1))
        ;;
    3)
        PATCH_VERSION=$((PATCH_VERSION+1))
        ;;
    4)
        read -p "Enter a pre-release name (ALPHA|BETA|RC): " PRE_RELEASE
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

# Update the .env file
sed -i '' "s/MAJOR_VERSION=.*/MAJOR_VERSION=$MAJOR_VERSION/" .env
sed -i '' "s/MINOR_VERSION=.*/MINOR_VERSION=$MINOR_VERSION/" .env
sed -i '' "s/PATCH_VERSION=.*/PATCH_VERSION=$PATCH_VERSION/" .env
sed -i '' "s/PRE_RELEASE=.*/PRE_RELEASE=$PRE_RELEASE/" .env

echo ""

# Print out the new version name
echo " - New Version Name : $MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION-$PRE_RELEASE"

echo "updated .env!"