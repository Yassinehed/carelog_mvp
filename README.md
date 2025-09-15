# CareLog MVP 🚀

[![Flutter](https://img.shields.io/badge/Flutter-3.32.5-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success.svg)]()

**Sistema completo di gestione segnalazioni e ordini di produzione con controllo costi integrato**

CareLog MVP è un'applicazione web moderna sviluppata con Flutter che permette di gestire segnalazioni e ordini di produzione con un sistema avanzato di controllo costi e sicurezza.

## ✨ Caratteristiche Principali

### 🔐 **Sicurezza Enterprise**
- **Autenticazione Firebase** sicura
- **Controllo Costi Real-time** con kill switch automatico
- **Monitoraggio Cloud Functions** per prevenzione superamento budget
- **Firestore Security Rules** complete

### 🎯 **Gestione Completa**
- **📝 Segnalazioni**: Creazione, lista, aggiornamento stato
- **🏭 Ordini Produzione**: Gestione completa ciclo di vita
- **📊 Dashboard Analytics**: Statistiche real-time
- **⚙️ Pannello Admin**: Controlli manutenzione e simulazione

### 🏗️ **Architettura Moderna**
- **Clean Architecture** con separazione layer
- **State Management** reattivo con Riverpod
- **Dependency Injection** con Injectable
- **Material Design 3** responsive

## 🚀 Quick Start

### Prerequisiti
- **Flutter 3.32.5+**
- **Dart 3.8.1+**
- **Firebase CLI**
- **Node.js 18+** (per Cloud Functions)

### Installazione

```bash
# 1. Clona il repository
git clone https://github.com/Yassinehed/carelog_mvp.git
cd carelog_mvp

# 2. Installa dipendenze
flutter pub get

# 3. Configura Firebase
firebase login
firebase init

# 4. Setup Cloud Functions
cd functions
npm install

# 5. Avvia in modalità sviluppo
flutter run -d chrome
```

### Deployment Produzione

```bash
# Build ottimizzato per produzione
flutter build web --release

# Deploy completo (Functions + Rules)
npm run deploy:all
```

## 📁 Struttura Progetto

```
carelog_mvp/
├── lib/
│   ├── core/                    # Utilità condivise
│   ├── features/               # Moduli funzionali
│   │   ├── auth/               # Autenticazione
│   │   ├── signalement/        # Gestione segnalazioni
│   │   ├── of_order/           # Ordini produzione
│   │   └── admin/              # Dashboard admin
│   └── injection.dart          # DI configuration
├── functions/                  # Cloud Functions
├── test/                       # Test suite
├── docs/                       # Documentazione
└── build/web/                  # Build produzione
```

## 🛠️ Tecnologie Utilizzate

### **Frontend**
- **Flutter** - Framework UI cross-platform
- **Riverpod** - State management reattivo
- **Material Design 3** - Design system moderno

### **Backend**
- **Firebase Auth** - Autenticazione sicura
- **Cloud Firestore** - Database NoSQL real-time
- **Cloud Functions** - Backend serverless
- **Firebase App Check** - Sicurezza aggiuntiva

### **Development**
- **Injectable** - Dependency injection
- **Freezed** - Code generation per modelli
- **Flutter Localizations** - Supporto multilingua

## 📊 Dashboard & Analytics

- **📈 Statistiche Real-time**: Monitoraggio segnalazioni e ordini
- **💰 Controllo Budget**: Alert automatici e kill switch
- **🔧 Pannello Admin**: Controlli manutenzione e configurazione
- **📱 Responsive**: Ottimizzato per desktop e mobile

## 🔒 Sicurezza

- **Autenticazione obbligatoria** per tutti gli accessi
- **Validazione lato client e server**
- **Monitoraggio costi** con limiti configurabili
- **Modalità manutenzione** per aggiornamenti sicuri
- **Firestore rules** per controllo accesso dati

## 🚀 Deployment

### Configurazione Firebase
1. Crea progetto Firebase Console
2. Abilita Authentication, Firestore, Functions
3. Configura service account per Functions
4. Imposta variabili ambiente budget

### Script Deployment
```bash
# Deployment completo automatizzato
npm run deploy:all
```

Vedi [docs/README_DEPLOYMENT.md](docs/README_DEPLOYMENT.md) per dettagli completi.

## 📚 Documentazione

- **[📋 Release Notes](RELEASE_NOTES.md)** - Note di rilascio v1.0.0
- **[🚀 Deployment Guide](functions/README.md)** - Guida deployment
- **[🔒 Security](docs/SECURITY.md)** - Documentazione sicurezza
- **[📱 Responsive Design](docs/RESPONSIVE_AND_LOCALIZATION.md)** - Design system

## 🧪 Testing

```bash
# Run tests
flutter test

# Coverage report
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

## 🤝 Contributi

1. Fork il progetto
2. Crea branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Apri Pull Request

## 📝 License

Distribuito sotto licenza MIT. Vedi `LICENSE` per maggiori informazioni.

## 👥 Autori

- **Yassine Hedhli** - *Development & Architecture*

## 🙏 Ringraziamenti

- Flutter Team per il fantastico framework
- Firebase Team per l'infrastruttura cloud
- Community Flutter per il supporto continuo

---

**CareLog MVP** - *Production Ready* 🎉

*Built with ❤️ using Flutter & Firebase*</content>
<parameter name="oldString"># carelog_mvp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
