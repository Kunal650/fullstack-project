# 🚀 GitHub Actions Setup Script for iOS Builds

Write-Host "🚀 Setting up GitHub Actions for iOS builds..." -ForegroundColor Green
Write-Host ""

Write-Host "📋 Step 1: Create GitHub Repository" -ForegroundColor Yellow
Write-Host "1. Go to https://github.com"
Write-Host "2. Click 'New repository'"
Write-Host "3. Name it: fullstack-project"
Write-Host "4. Make it Public (for free GitHub Actions)"
Write-Host "5. Don't initialize with README"
Write-Host "6. Click 'Create repository'"
Write-Host ""

$github_username = Read-Host "Enter your GitHub username"
$repo_name = Read-Host "Enter your repository name (default: fullstack-project)"

if ([string]::IsNullOrEmpty($repo_name)) {
    $repo_name = "fullstack-project"
}

Write-Host ""
Write-Host "🔗 Adding GitHub remote..." -ForegroundColor Blue
git remote add origin "https://github.com/$github_username/$repo_name.git"

Write-Host ""
Write-Host "📤 Pushing code to GitHub..." -ForegroundColor Blue
git branch -M main
git push -u origin main

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 Next steps:" -ForegroundColor Yellow
Write-Host "1. Go to your GitHub repository"
Write-Host "2. Click 'Actions' tab"
Write-Host "3. Watch your iOS app build automatically!"
Write-Host ""
Write-Host "📱 Your iOS app will build in the cloud using GitHub Actions" -ForegroundColor Cyan
Write-Host "🍎 No local macOS required!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
