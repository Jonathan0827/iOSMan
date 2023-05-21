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

# codesign --remove "$TARGET_APP"
#if [ -e "$TARGET_APP/_CodeSignature" ]; then
 #   rm -rf "$TARGET_APP/_CodeSignature"
#fi
#if [ -e "$TARGET_APP/embedded.mobileprovision" ]; then
#    rm -rf "$TARGET_APP/embedded.mobileprovision"
#fi

# Add entitlements
#echo "Adding entitlements"
#chmod a+x $WORKING_LOCATION/bin/ldid
#$WORKING_LOCATION/bin/ldid -S"$WORKING_LOCATION/entitlements.plist" "$TARGET_APP/$APPLICATION_NAME"`
rm -rf DerivedDataApp
if [ -d "iOSMan.pkg" ]; then
  rm -rf iOSMan.pkg
fi
sudo pkgbuild --install-location /Applications --component iOSMan.app ./iOSMan.pkg
#cp -r "../build/$APPLICATION_NAME.app" ./
#cd ..
#if [ -f "iOSMan-Installer.dmg" ]; then
#  rm iOSMan-Installer.dmg
#fi
#create-dmg \
#  --volname "$APPLICATION_NAME Installer" \
#  --window-pos 200 120 \
#  --window-size 800 450 \
#  --icon-size 100 \
#  --icon "$APPLICATION_NAME.app" 200 190 \
#  --hide-extension "$APPLICATION_NAME.app" \
#  --app-drop-link 600 185 \
#  "$APPLICATION_NAME-Installer.dmg" \
#  "$WORKING_LOCATION/build/"
#diutil create "$WORKING_LOCATION/$APPLICATION_NAME.dmg" -ov -volname "$APPLICATION_NAME Installer" -fs HFS+ -srcfolder "$WORKING_LOCATION/release"
