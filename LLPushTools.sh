#!/bin/sh
# Merge Script

# 1
# Set bash script to exit immediately if any commands fail.
set -e

# 2
# Setup some constants for use later on.
FRAMEWORK_NAME="LLPushTools"

# 3
# If remnants from a previous build exist, delete them.
if [ -d "$(PWD)/build" ]; then
rm -rf "$(PWD)/build"
fi

# 4
# Build the framework for device and for simulator (using
# all needed architectures).
xcodebuild -workspace LLPushTools.xcworkspace -scheme LLPushTools -configuration Release -arch arm64 only_active_arch=no defines_module=yes -sdk "iphoneos" OBJROOT=$(PWD)/build/Products/Release-iphoneos SYMROOT=$(PWD)/build/Products/Release-iphoneos
xcodebuild -workspace LLPushTools.xcworkspace -scheme LLPushTools -configuration Release -arch x86_64 only_active_arch=no defines_module=yes -sdk "iphonesimulator" OBJROOT=$(PWD)/build/Products/Release-iphonesimulator SYMROOT=$(PWD)/build/Products/Release-iphonesimulator

# 5
# Remove .framework file if exists on Desktop from previous run.
if [ -d "$(PWD)/${FRAMEWORK_NAME}.framework" ]; then
rm -rf "$(PWD)/${FRAMEWORK_NAME}.framework"
fi

cp -R "$(PWD)/build/Products/Release-iphoneos/Release-iphoneos/${FRAMEWORK_NAME}.framework" "$(PWD)/"
# 6
# Copy the device version of framework to Desktop.
# cp -r "$(PWD)/build/Release-iphoneos/${FRAMEWORK_NAME}.framework" "${SRCROOT}/${FRAMEWORK_NAME}.framework"

# 7
# Replace the framework executable within the framework with
# a new version created by merging the device and simulator
# frameworks' executables with lipo.
#lipo -create "$(PWD)/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "$(PWD)/build/Products/Release-iphonesimulator/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" -output "$(PWD)/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"
lipo -create -output "$(PWD)/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "$(PWD)/build/Products/Release-iphoneos/Release-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "$(PWD)/build/Products/Release-iphonesimulator/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

# 8
# Copy the Swift module mappings for the simulator into the
# framework.  The device mappings already exist from step 6.
cp -r "$(PWD)/build/Products/Release-iphonesimulator/Release-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/" "$(PWD)/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"

# 9
# Delete the most recent build.
if [ -d "${SRCROOT}/build" ]; then
rm -rf "${SRCROOT}/build"
fi
