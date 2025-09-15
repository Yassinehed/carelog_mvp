#!/bin/bash

# CareLog MVP - Deployment Script
# Version: 1.0.0

echo "🚀 CareLog MVP - Deployment Script v1.0.0"
echo "================================================"

# Check prerequisites
echo -e "\n📋 Checking prerequisites..."

if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Please install Flutter SDK."
    exit 1
fi

if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Please install Firebase CLI."
    exit 1
fi

echo "✅ Prerequisites OK"

# Build Flutter web app
echo -e "\n🔨 Building Flutter web app..."
flutter build web --release

if [ $? -ne 0 ]; then
    echo "❌ Flutter build failed!"
    exit 1
fi

echo "✅ Flutter build completed"

# Deploy Cloud Functions
echo -e "\n☁️  Deploying Cloud Functions..."
cd functions
npm run deploy

if [ $? -ne 0 ]; then
    echo "❌ Cloud Functions deployment failed!"
    cd ..
    exit 1
fi

cd ..
echo "✅ Cloud Functions deployed"

# Deploy Firestore Rules
echo -e "\n📄 Deploying Firestore Rules..."
firebase deploy --only firestore:rules

if [ $? -ne 0 ]; then
    echo "❌ Firestore Rules deployment failed!"
    exit 1
fi

echo "✅ Firestore Rules deployed"

# Final message
echo -e "\n🎉 Deployment completed successfully!"
echo "================================================"
echo "🚀 CareLog MVP v1.0.0 is now live!"
echo "================================================"