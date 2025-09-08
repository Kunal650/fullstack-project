#!/bin/bash

# iOS Project Verification Script

echo "🔍 Verifying iOS project structure..."

# Check if we're in the right directory
if [ ! -d "ios" ]; then
    echo "❌ Not in project root directory"
    exit 1
fi

cd ios

echo "📁 Checking project files..."

# Check for Xcode project
if [ -f "ProjectApp.xcodeproj/project.pbxproj" ]; then
    echo "✅ Xcode project found"
else
    echo "❌ Xcode project not found"
    exit 1
fi

# Check for main app files
if [ -f "ProjectApp/ProjectAppApp.swift" ]; then
    echo "✅ Main app file found"
else
    echo "❌ Main app file not found"
    exit 1
fi

if [ -f "ProjectApp/ContentView.swift" ]; then
    echo "✅ Content view found"
else
    echo "❌ Content view not found"
    exit 1
fi

if [ -f "ProjectApp/Info.plist" ]; then
    echo "✅ Info.plist found"
else
    echo "❌ Info.plist not found"
    exit 1
fi

# Check for assets
if [ -d "ProjectApp/Assets.xcassets" ]; then
    echo "✅ Assets directory found"
else
    echo "❌ Assets directory not found"
    exit 1
fi

# Check for Podfile (optional)
if [ -f "Podfile" ]; then
    echo "✅ Podfile found"
else
    echo "⚠️  Podfile not found (will build without CocoaPods)"
fi

# Check for workspace (if CocoaPods was used)
if [ -f "ProjectApp.xcworkspace" ]; then
    echo "✅ Workspace found (CocoaPods)"
else
    echo "⚠️  Workspace not found (no CocoaPods)"
fi

echo ""
echo "🎯 Project structure verification complete!"
echo "✅ All essential files are present"
echo "🚀 Ready for building!"

exit 0
