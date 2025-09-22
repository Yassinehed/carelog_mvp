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

Seeder (opzionale)
-------------------
Per configurare dati di test nell'emulatore (utenti Auth, documenti Firestore) sono stati aggiunti gli script di seeding:

- `scripts/seed_emulator.sh` — script bash che esegue `node scripts/seed_firestore.js` (Linux/macOS/CI)
- `scripts/seed_emulator.ps1` — script PowerShell (Windows)
- `scripts/seed_firestore.js` — piccolo seeder Node.js che:
	- crea un utente test `test.user+emulator@example.com` nell'Auth emulator
	- inserisce un documento di esempio in `Firestore/sample/seed1`

Esempio (locale):

```powershell
# Avvia gli emulatori (in un terminale)
firebase emulators:start --only auth,firestore,functions

# In un altro terminale su Windows
.\scripts\seed_emulator.ps1

# Poi esegui i test di integrazione
flutter test integration_test/emulator_integration_test.dart
```

Esempio (CI): il workflow usa `firebase emulators:exec` e cerca `scripts/seed_emulator.sh` automaticamente; assicurati che `node` sia installato nel runner.
