#!/bin/bash

# Simple iOS Project Test Script

echo "🧪 Testing iOS project structure..."

# Check if we're in the right directory
if [ -d "ProjectApp" ]; then
    echo "✅ Already in ios directory"
elif [ -d "ios" ]; then
    echo "✅ In project root, changing to ios directory"
    cd ios
else
    echo "❌ Not in project root or ios directory"
    exit 1
fi

echo "📁 Project structure:"
echo "ProjectApp directory:"
ls -la ProjectApp/

echo ""
echo "Xcode project:"
ls -la ProjectApp.xcodeproj/

echo ""
echo "🎯 Project files check:"
if [ -f "ProjectApp/ProjectAppApp.swift" ]; then
    echo "✅ ProjectAppApp.swift found"
else
    echo "❌ ProjectAppApp.swift missing"
fi

if [ -f "ProjectApp/ContentView.swift" ]; then
    echo "✅ ContentView.swift found"
else
    echo "❌ ContentView.swift missing"
fi

if [ -f "ProjectApp/Info.plist" ]; then
    echo "✅ Info.plist found"
else
    echo "❌ Info.plist missing"
fi

if [ -d "ProjectApp/Assets.xcassets" ]; then
    echo "✅ Assets.xcassets found"
else
    echo "❌ Assets.xcassets missing"
fi

echo ""
echo "🎉 Project structure test complete!"
exit 0
