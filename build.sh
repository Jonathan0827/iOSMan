#!/bin/bash

set -e

cd "$(dirname "$0")"

WORKING_LOCATION="$(pwd)"
APPLICATION_NAME=iOSMan

if [ ! -d "build" ]; then
    mkdir build
fi
cd build

xcodebuild -project "$WORKING_LOCATION/$APPLICATION_NAME/$APPLICATION_NAME.xcodeproj" \
    -scheme "$APPLICATION_NAME" \
    -configuration Release \
    -derivedDataPath "$WORKING_LOCATION/build/DerivedDataApp" \
    -destination 'generic/platform=macOS' \
    clean build \
    ONLY_ACTIVE_ARCH="NO" \
    CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO" \

DD_APP_PATH="$WORKING_LOCATION/build/DerivedDataApp/Build/Products/Release/$APPLICATION_NAME.app"
TARGET_APP="$WORKING_LOCATION/build/$APPLICATION_NAME.app"
cp -r "$DD_APP_PATH" "$TARGET_APP"


rm -rf DerivedDataApp
if [ -d "iOSMan.pkg" ]; then
  rm -rf iOSMan.pkg
fi
sudo pkgbuild --install-location /Applications --component iOSMan.app ./iOSMan.pkg
