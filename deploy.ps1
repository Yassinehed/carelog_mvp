# CareLog MVP - Deployment Script
# Version: 1.0.0

Write-Host "🚀 CareLog MVP - Deployment Script v1.0.0" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# Check prerequisites
Write-Host "`n📋 Checking prerequisites..." -ForegroundColor Yellow

if (!(Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Flutter not found. Please install Flutter SDK." -ForegroundColor Red
    exit 1
}

if (!(Get-Command firebase -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Firebase CLI not found. Please install Firebase CLI." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Prerequisites OK" -ForegroundColor Green

# Build Flutter web app
Write-Host "`n🔨 Building Flutter web app..." -ForegroundColor Yellow
flutter build web --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flutter build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Flutter build completed" -ForegroundColor Green

# Deploy Cloud Functions
Write-Host "`n☁️  Deploying Cloud Functions..." -ForegroundColor Yellow
Set-Location functions
npm run deploy

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Cloud Functions deployment failed!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Set-Location ..
Write-Host "✅ Cloud Functions deployed" -ForegroundColor Green

# Deploy Firestore Rules
Write-Host "`n📄 Deploying Firestore Rules..." -ForegroundColor Yellow
firebase deploy --only firestore:rules

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Firestore Rules deployment failed!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Firestore Rules deployed" -ForegroundColor Green

# Final message
Write-Host "`n🎉 Deployment completed successfully!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "🚀 CareLog MVP v1.0.0 is now live!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan