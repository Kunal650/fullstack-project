@echo off
echo 🚀 Setting up GitHub Actions for iOS builds...
echo.

echo 📋 Step 1: Create GitHub Repository
echo 1. Go to https://github.com
echo 2. Click "New repository"
echo 3. Name it: fullstack-project
echo 4. Make it Public (for free GitHub Actions)
echo 5. Don't initialize with README
echo 6. Click "Create repository"
echo.

set /p github_username="Enter your GitHub username: "
set /p repo_name="Enter your repository name (default: fullstack-project): "

if "%repo_name%"=="" set repo_name=fullstack-project

echo.
echo 🔗 Adding GitHub remote...
git remote add origin https://github.com/%github_username%/%repo_name%.git

echo.
echo 📤 Pushing code to GitHub...
git branch -M main
git push -u origin main

echo.
echo ✅ Setup complete!
echo.
echo 🎯 Next steps:
echo 1. Go to your GitHub repository
echo 2. Click "Actions" tab
echo 3. Watch your iOS app build automatically!
echo.
echo 📱 Your iOS app will build in the cloud using GitHub Actions
echo 🍎 No local macOS required!
echo.
pause
