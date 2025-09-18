# CareLog MVP - Contributing Guide

## 🚀 Getting Started

### Prerequisites
- **Flutter 3.32.5+**
- **Dart 3.8.1+**
- **Firebase CLI** (for deployment)
- **Node.js 18+** (for Cloud Functions)
- **Git**

### Local Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Yassinehed/carelog_mvp.git
   cd carelog_mvp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   cd functions && npm install && cd ..
   ```

3. **Configure Firebase** (optional for UI testing)
   ```bash
   firebase login
   firebase init
   cp .env.example .env
   # Edit .env with your Firebase config
   ```

4. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run -d chrome
   ```

## 🏗️ Project Structure

```
carelog_mvp/
├── lib/
│   ├── core/                    # Shared utilities & providers
│   ├── features/               # Feature modules
│   │   ├── auth/               # Authentication
│   │   ├── signalement/        # Signalements management
│   │   ├── of_order/           # Orders management
│   │   └── admin/              # Admin dashboard
│   ├── l10n/                   # Localization
│   └── injection.dart          # Dependency injection
├── functions/                  # Cloud Functions
├── test/                       # Unit & widget tests
├── docs/                       # Documentation
└── build/web/                  # Production build
```

## 🛠️ Development Workflow

### Code Style
- Follow Flutter's [effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter analyze` to check code quality
- Run `flutter format .` to format code

### Architecture Principles
- **Clean Architecture** with clear separation of layers
- **Riverpod** for state management
- **Repository Pattern** for data access
- **Dependency Injection** with Injectable

### Git Workflow
1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes and test thoroughly
3. Run tests: `flutter test`
4. Commit with clear message: `git commit -m "feat: add new feature"`
5. Push and create PR

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Code Coverage
```bash
flutter test --coverage
# View report in coverage/html/index.html
```

## 🚀 Deployment

### Web Deployment
```bash
# Build for production
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

### Cloud Functions Deployment
```bash
cd functions
npm run deploy
```

### Full Deployment
```bash
# Use the automated script
./deploy.sh  # Linux/Mac
# or
./deploy.ps1 # Windows
```

## 📋 Pull Request Guidelines

### Before Submitting
- [ ] Tests pass locally
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] No breaking changes without discussion

### PR Description Template
```
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots of UI changes
```

## 🔧 Troubleshooting

### Common Issues

**Firebase connection fails**
- Check `.env` configuration
- Verify Firebase project settings
- Ensure service account key is valid

**Build fails**
- Run `flutter clean && flutter pub get`
- Check Flutter version compatibility
- Verify all dependencies are installed

**Tests fail**
- Run `flutter pub run build_runner build`
- Check test data and mocks
- Verify Firebase emulator setup

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 🤝 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help newcomers learn
- Focus on quality and maintainability

## 📞 Support

For questions or issues:
1. Check existing issues on GitHub
2. Create a new issue with detailed description
3. Contact the maintainers

---

Happy coding! 🎉