# Eseguire i test con Firebase Emulator Suite

Questa guida spiega come eseguire i test widget/integration che usano il Firebase Emulator Suite.

Prerequisiti:
- Firebase CLI installato (https://firebase.google.com/docs/cli)
- Node.js installato
- Avere i servizi emulator attivi: Auth, Firestore, Functions

1) Avviare gli emulator locali nella root del progetto:

```bash
firebase emulators:start --only auth,firestore,functions
```

2) In un altro terminale, eseguire i test widget (IntegrationTest richiede un ambiente con plugin)

```bash
# Esegui i test unit/widget che usano l'emulatore
flutter test test/widget_with_emulator_test.dart

# Esegui i test di integrazione (richiede device/driver)
flutter test integration_test/emulator_integration_test.dart
```

Nota: I test sono scritti per rilevare se l'emulatore è attivo e saltano automaticamente quando non disponibile. Per eseguire test reali assicurati che l'emulatore sia in esecuzione e che le porte standard (Auth:9099, Firestore:8080) siano libere.
