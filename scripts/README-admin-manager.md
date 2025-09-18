# Admin Claim Management Script

Questo script fornisce una gestione sicura dei privilegi amministrativi per gli utenti Firebase nel progetto CareLog MVP.

## 🚀 Funzionalità

- ✅ **Concessione privilegi admin** - Assegna il ruolo amministratore a un utente
- ✅ **Revoca privilegi admin** - Rimuovi il ruolo amministratore da un utente
- ✅ **Verifica privilegi** - Controlla se un utente ha privilegi amministrativi
- ✅ **Supporto emulatori** - Compatibile con Firebase Emulator Suite
- ✅ **Sicurezza avanzata** - Gestione sicura delle credenziali

## 📋 Prerequisiti

### 1. Service Account Key
Scarica la chiave dell'account di servizio da Firebase Console:

1. Vai su [Firebase Console](https://console.firebase.google.com/)
2. Seleziona il progetto "carelog-mv"
3. Vai su ⚙️ **Impostazioni progetto** → **Account di servizio**
4. Clicca su **Genera nuova chiave privata**
5. Salva il file JSON come `service-account-key.json`
6. **IMPORTANTE**: Posizionalo in `carelog_mvp/keys/service-account-key.json`

### 2. Dipendenze
```bash
npm install firebase-admin
```

## 🛠️ Installazione

Lo script è già creato in `scripts/admin-manager.js`. Assicurati che il file sia eseguibile:

```bash
# Su Windows (PowerShell)
# Non è necessario chmod su Windows
```

## 📖 Utilizzo

### Sintassi Base
```bash
node scripts/admin-manager.js <comando> [argomenti]
```

### Comandi Disponibili

#### 👑 Concedi Privilegi Admin
```bash
node scripts/admin-manager.js grant <user-uid>
```

**Esempio:**
```bash
node scripts/admin-manager.js grant abc123def456
```

#### 🚫 Revoca Privilegi Admin
```bash
node scripts/admin-manager.js revoke <user-uid>
```

**Esempio:**
```bash
node scripts/admin-manager.js revoke abc123def456
```

#### 🔍 Verifica Privilegi Admin
```bash
node scripts/admin-manager.js check <user-uid>
```

**Esempio:**
```bash
node scripts/admin-manager.js check abc123def456
```

#### 📋 Lista Utenti Admin
```bash
node scripts/admin-manager.js list
```

**Nota:** Questa funzionalità richiede implementazione aggiuntiva (vedi sezione Sviluppo)

#### ❓ Mostra Guida
```bash
node scripts/admin-manager.js help
```

## ⚙️ Configurazione

### Variabili d'Ambiente

| Variabile | Descrizione | Default |
|-----------|-------------|---------|
| `FIREBASE_PROJECT_ID` | ID del progetto Firebase | `carelog-mv` |
| `FIREBASE_SERVICE_KEY` | Percorso al file chiave servizio | `keys/service-account-key.json` |
| `USE_EMULATOR` | Usa Firebase Emulator Suite | `false` |

### Esempi di Configurazione

#### Ambiente di Sviluppo (con Emulatori)
```bash
# Su Windows (PowerShell)
$env:FIREBASE_PROJECT_ID="carelog-mv"
$env:USE_EMULATOR="true"
node scripts/admin-manager.js grant user123
```

#### Ambiente di Produzione
```bash
# Su Windows (PowerShell)
$env:FIREBASE_PROJECT_ID="carelog-mv"
$env:FIREBASE_SERVICE_KEY="C:\path\to\service-account-key.json"
node scripts/admin-manager.js grant user123
```

## 🔧 Utilizzo con Emulatori

Per testare lo script in ambiente di sviluppo:

1. **Avvia gli emulatori:**
   ```bash
   firebase emulators:start --only auth,firestore
   ```

2. **In un altro terminal, configura l'ambiente:**
   ```bash
   # Su Windows (PowerShell)
   $env:USE_EMULATOR="true"
   ```

3. **Esegui i comandi:**
   ```bash
   node scripts/admin-manager.js grant test-user-123
   node scripts/admin-manager.js check test-user-123
   ```

## 🛡️ Sicurezza

### ⚠️ Avvertenze Importanti

1. **Credenziali Sensibili**: Il file `service-account-key.json` contiene credenziali sensibili
2. **Non committare**: Mai committare questo file su Git
3. **Permessi limitati**: Concedi solo i privilegi necessari
4. **Audit logging**: Mantieni traccia delle operazioni amministrative

### 📁 Struttura Sicura
```
carelog_mvp/
├── keys/
│   └── service-account-key.json  # ❌ NON committare
├── scripts/
│   └── admin-manager.js
└── .gitignore
    # Aggiungi questa riga:
    keys/service-account-key.json
```

## 🧪 Test

### Test con Emulatori
```bash
# 1. Avvia emulatori
firebase emulators:start --only auth,firestore

# 2. In altro terminal
$env:USE_EMULATOR="true"
node scripts/admin-manager.js grant test-user-123
node scripts/admin-manager.js check test-user-123
node scripts/admin-manager.js revoke test-user-123
```

### Test in Produzione
```bash
# ⚠️  USA CON CAUTELA - Opera su dati reali
node scripts/admin-manager.js check existing-user-uid
```

## 🔄 Sviluppo e Manutenzione

### Funzionalità Future
- [ ] **Lista utenti admin completa** - Implementare collection Firestore per tracciare admin
- [ ] **Audit logging** - Log di tutte le operazioni amministrative
- [ ] **Batch operations** - Gestione massiva di privilegi
- [ ] **Role-based access** - Supporto per ruoli multipli (admin, moderator, etc.)

### Estensioni
```javascript
// Esempio: Aggiungere supporto per ruoli multipli
await admin.auth().setCustomUserClaims(uid, {
  admin: true,
  moderator: false,
  role: 'super-admin'
});
```

## 🐛 Troubleshooting

### Errore: "Service account key not found"
```
❌ Service account key not found at: keys/service-account-key.json
```
**Soluzione:** Scarica e posiziona il file chiave servizio nella directory corretta.

### Errore: "Failed to initialize Firebase"
```
❌ Failed to initialize Firebase: Error: Unable to parse JSON
```
**Soluzione:** Verifica che il file JSON della chiave servizio sia valido.

### Errore: "USE_EMULATOR not working"
**Soluzione:** Assicurati che gli emulatori siano avviati prima di eseguire lo script.

## 📞 Supporto

Per problemi o domande:
1. Verifica i log di errore dettagliati
2. Controlla la configurazione delle variabili d'ambiente
3. Assicurati che gli emulatori siano attivi (se usi USE_EMULATOR=true)
4. Verifica i permessi del file chiave servizio

## 📝 Note di Versione

- **v1.0.0** - Implementazione iniziale con grant/revoke/check
- Supporto completo per Firebase Emulator Suite
- Gestione sicura delle credenziali
- Documentazione completa