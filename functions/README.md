# CareLog MVP - Cost Control System

## Sistema di Controllo Costi

Questo documento descrive come implementare e configurare il sistema di controllo costi che protegge l'applicazione da superamenti di budget.

## 🏗️ Architettura

Il sistema utilizza un approccio "Kill Switch" che disabilita automaticamente le operazioni di scrittura quando il budget Google Cloud viene superato:

1. **Google Cloud Budget** → Pub/Sub Alert → **Cloud Function** → **Firestore Update** → **App Disabilitata**

## 📋 Prerequisiti

- Firebase CLI installato: `npm install -g firebase-tools`
- Google Cloud Console access
- Firebase project configurato
- Node.js 18+ installato
- Budget di almeno €50 configurato su GCP

## 🚀 Deployment Cloud Functions

### 1. Installa dipendenze

```bash
cd functions
npm install
```

### 2. Configura Firebase

```bash
# Login con il tuo account Google
firebase login

# Seleziona/aggiungi il progetto Firebase
firebase use --add
# Scegli il tuo progetto dalla lista o inserisci l'ID progetto
```

### 3. Deploy delle Functions

```bash
# Deploy solo delle functions
firebase deploy --only functions

# O deploy completo (functions + hosting se configurato)
firebase deploy
```

### 4. Verifica deployment

```bash
# Lista delle functions deployate
firebase functions:list

# Dovresti vedere:
# ┌─────────────────┬──────────┬─────────────┬─────────────┐
# │ Function       │ Region   │ Trigger     │ URL         │
# ├─────────────────┼──────────┼─────────────┼─────────────┤
# │ onBudgetExceeded│ us-central1 │ Pub/Sub    │ -          │
# │ resetReadOnlyMode│ us-central1 │ HTTP       │ [URL]     │
# │ getSystemStatus │ us-central1 │ HTTP       │ [URL]     │
# └─────────────────┴──────────┴─────────────┴─────────────┘
```

## 🧪 Testing Locale (Firebase Emulator)

### 1. Avvia l'emulatore

```bash
cd functions
npm run serve
# oppure
firebase emulators:start --only functions
```

### 2. Test delle Functions

In un altro terminale:

```bash
# Apri la shell delle functions
firebase functions:shell

# Test resetReadOnlyMode
resetReadOnlyMode.post({}).then(console.log)

# Test getSystemStatus
getSystemStatus.post({}).then(console.log)

# Simula Pub/Sub message per onBudgetExceeded
onBudgetExceeded({
  json: {
    costAmount: 55,
    budgetAmount: 50
  }
})
```

### 3. Test con l'App

Mentre l'emulatore è attivo, l'app utilizzerà automaticamente le functions locali invece di quelle deployate.

## ⚙️ Configurazione Budget Alert GCP

### 1. Accesso Google Cloud Console

1. Vai su [Google Cloud Console](https://console.cloud.google.com/)
2. Seleziona il tuo progetto Firebase/GCP
3. Naviga: **Billing** → **Budgets & alerts**

### 2. Crea Nuovo Budget

1. Clicca **CREATE BUDGET**
2. **Nome**: `carelog-mvp-budget`
3. **Tipo Budget**:
   - Seleziona: "Specified amount"
   - **Importo**: €50.00 (o il limite mensile desiderato)
4. **Scope del Progetto**:
   - "All projects" o specifica il progetto
5. **Periodo**: Monthly (mensile)

### 3. Configura Alert di Budget

1. Nella sezione **Set budget alerts**:
   - **Trigger alert when**: `Actual cost`
   - **Threshold**: `100%` (quando raggiungi il 100% del budget)
   - **Rename alert**: "Budget Exceeded Alert"
   - **Email recipients**: Aggiungi gli amministratori

2. **IMPORTANTE**: Nella sezione **Manage notifications**:
   - Seleziona **"Connect a Pub/Sub topic to this budget alert"**
   - **Topic name**: `budget-alerts`
   - Clicca **DONE**

### 4. Verifica Configurazione

1. Vai su **Pub/Sub** → **Topics** nella Cloud Console
2. Verifica che esista il topic `budget-alerts`
3. Il budget alert invierà automaticamente messaggi JSON a questo topic

## 🔧 Testing del Sistema

### Test Manuale (Dashboard Admin)

1. Accedi come amministratore nell'app
2. Vai su **Dashboard Amministratore** (icona admin)
3. Nella sezione **Budget Simulation & Testing**:
   - Clicca **"Simula Superamento Budget"** per testare
   - Verifica che l'app si disabiliti
   - Usa **"Ripristina Normale"** per tornare operativo

### Test con Cloud Function Deployata

```javascript
// Da browser console o app
import { getFunctions, httpsCallable } from 'firebase/functions';

const functions = getFunctions();
const resetFunction = httpsCallable(functions, 'resetReadOnlyMode');

resetFunction()
  .then(result => console.log('Reset successful:', result))
  .catch(error => console.error('Reset failed:', error));
```

### Test Budget Alert (Produzione)

Per testare il flusso completo in produzione:

1. **Riduci temporaneamente il budget** a €1
2. **Genera costi** usando l'app (scritture Firestore)
3. **Attendi l'alert** (può richiedere fino a qualche ora)
4. **Verifica** che il sistema si disabiliti automaticamente

## 📊 Monitoraggio e Logging

### Stato Sistema in Firestore

Il documento `/config/system_status` contiene:

```json
{
  "isReadOnly": true,
  "maintenanceMessage": "Sistema in modalità manutenzione per superamento budget. Costo attuale: €55, Budget: €50",
  "lastUpdated": "2025-09-13T10:30:00Z",
  "budgetExceeded": true,
  "budgetAmount": 50,
  "currentCost": 55,
  "simulated": false
}
```

### Log Cloud Functions

```bash
# Vedi tutti i log
firebase functions:log

# Log di una function specifica
firebase functions:log --only onBudgetExceeded

# Log in tempo reale
firebase functions:log --only onBudgetExceeded --open
```

### Monitoraggio GCP

1. **Cloud Functions** → **Logs** per vedere esecuzioni
2. **Pub/Sub** → **Topics** → `budget-alerts` per messaggi
3. **Billing** → **Budgets** per stato corrente
4. **Firestore** → **Data** per stato sistema

## 🔒 Sicurezza e Autenticazione

### Admin Functions

Le functions `resetReadOnlyMode` e `getSystemStatus` dovrebbero essere protette:

```javascript
// Aggiungere controllo admin (TODO nel codice)
exports.resetReadOnlyMode = functions.https.onCall(async (data, context) => {
  // Verifica autenticazione
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  // Verifica ruolo admin (implementare logica)
  const isAdmin = await checkAdminRole(context.auth.uid);
  if (!isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  // Procedi con reset...
});
```

### Firestore Security Rules

```javascript
// Regole aggiornate per controllo costi
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Sistema può sempre leggere stato
    match /config/system_status {
      allow read: if true;
      allow write: if false; // Solo Cloud Functions possono scrivere
    }

    // Operazioni normali controllate dal flag read-only
    match /{document=**} {
      allow read: if isAuthenticated();
      allow write: if isAuthenticated() && !isSystemReadOnly();
    }
  }

  function isAuthenticated() {
    return request.auth != null;
  }

  function isSystemReadOnly() {
    return get(/databases/$(database)/documents/config/system_status).data.isReadOnly == true;
  }
}
```

## 🚨 Recovery e Troubleshooting

### Reset Manuale

1. **Dashboard Admin** → **"Ripristina Normale"**
2. **Cloud Function** → Chiama `resetReadOnlyMode()`
3. **Firestore Console** → Aggiorna manualmente documento

### Problemi Comuni

#### Cloud Function non si attiva
```bash
# Controlla log
firebase functions:log --only onBudgetExceeded

# Verifica topic Pub/Sub
gcloud pubsub topics list
gcloud pubsub subscriptions list

# Test manuale del topic
gcloud pubsub topics publish budget-alerts --message '{"costAmount": 55, "budgetAmount": 50}'
```

#### App non si disabilita
- Verifica connessione Firestore
- Controlla che il documento `system_status` esista
- Testa lettura da dashboard admin

#### Budget alert non arriva
- Verifica configurazione email in GCP
- Controlla che il budget sia attivo
- Testa con soglie più basse (10%, 50%)
- Attendi fino a 24 ore per il primo alert

#### Errori di Deployment
```bash
# Pulisci cache
firebase functions:config:unset
firebase functions:delete onBudgetExceeded --region us-central1

# Ri-deploy
firebase deploy --only functions
```

## 📈 Best Practices

### 1. Monitoraggio Continuo
- Imposta alert multipli (50%, 75%, 90%, 100%)
- Monitora regolarmente i log delle Cloud Functions
- Controlla periodicamente lo stato del sistema
- Imposta dashboard di monitoraggio GCP

### 2. Budget Planning
- Imposta budget realistici basati sull'uso storico
- Considera costi di scaling e picchi di utilizzo
- Mantieni un buffer di sicurezza (20-30%)
- Rivedi budget mensilmente

### 3. Sicurezza Admin
- Limita gli UID admin a personale autorizzato
- Implementa logging per azioni amministrative
- Usa autenticazione a due fattori per admin
- Ruota regolarmente le chiavi di servizio

### 4. Testing Regolare
- Testa mensilmente il sistema di kill switch
- Simula scenari di superamento budget
- Verifica procedure di recovery
- Documenta e aggiorna runbook

## 🚀 Deployment in Produzione

### Checklist Pre-Deployment

- [ ] Budget GCP configurato e attivo
- [ ] Pub/Sub topic `budget-alerts` creato
- [ ] Cloud Functions deployate e funzionanti
- [ ] Firestore security rules aggiornate
- [ ] Admin dashboard testata
- [ ] Sistema di notifica configurato

### Comandi Deployment Finale

```bash
# Deploy completo
cd functions
npm install
firebase use production-project-id
firebase deploy --only functions

# Verifica
firebase functions:list
firebase functions:log --only onBudgetExceeded --limit 5
```

### Post-Deployment

1. **Test completo** del sistema
2. **Monitora logs** per 24-48 ore
3. **Verifica alert** con budget di test ridotto
4. **Documenta** procedure di emergenza

## 📞 Supporto e Manutenzione

### Contatti
- **Team Sviluppo**: [email]
- **DevOps**: [email]
- **Documentazione**: Questo README

### Manutenzione Programmata
- Rivedi budget mensilmente
- Aggiorna dipendenze Node.js trimestralmente
- Testa sistema dopo aggiornamenti Firebase
- Monitora costi GCP regolarmente

---

**🎯 Risultato**: Sistema completamente automatizzato che protegge il budget GCP disabilitando l'app prima di costi eccessivi, con testing completo e recovery procedures documentate.
- `getSystemStatus` - Per monitoraggio

## ⚙️ Configurazione Budget Alert

### 1. Google Cloud Console

1. Vai su [Google Cloud Console](https://console.cloud.google.com/)
2. Seleziona il tuo progetto
3. Naviga: **Billing** → **Budgets & alerts**

### 2. Crea Budget

1. Clicca **CREATE BUDGET**
2. Nome: `carelog-budget`
3. Importo: €50 (o il limite desiderato)
4. Scope: Tutto il progetto

### 3. Configura Alert

1. Nella sezione **Set budget alerts**:
   - **Trigger alert when**: `Actual cost`
   - **Threshold**: `100%` (quando raggiungi il 100% del budget)
   - **Email recipients**: Aggiungi gli amministratori

### 4. Pub/Sub Topic

Il budget alert invierà automaticamente messaggi al topic `budget-alerts`. La Cloud Function `onBudgetExceeded` è già configurata per ascoltare questo topic.

## 🔧 Testing del Sistema

### Test Manuale (Dashboard Admin)

1. Accedi come amministratore
2. Vai su **Dashboard Amministratore**
3. Usa **"Simula Superamento Budget"** per testare

### Test con Cloud Function

```javascript
// Chiama la function per testing
const functions = getFunctions();
const result = await httpsCallable(functions, 'resetReadOnlyMode')();
```

## 📊 Monitoraggio

### Stato Sistema in Firestore

Il documento `/config/system_status` contiene:

```json
{
  "isReadOnly": true,
  "maintenanceMessage": "Sistema in modalità manutenzione...",
  "lastUpdated": "2025-01-13T10:30:00Z",
  "budgetExceeded": true,
  "budgetAmount": 50,
  "currentCost": 52
}
```

### Log Cloud Functions

```bash
firebase functions:log --only onBudgetExceeded
```

## 🔒 Security Rules

Le Firestore Security Rules bloccano automaticamente le scritture quando `isReadOnly = true`:

```javascript
function isSystemReadOnly() {
  return get(/databases/$(database)/documents/config/system_status).data.isReadOnly == true;
}

// Tutte le operazioni di scrittura controllano questo flag
allow write: if isAuthenticated() && !isSystemReadOnly();
```

## 🚨 Recovery

### Reset Manuale

1. Dashboard Admin → **"Toggle Read-Only"**
2. O chiama direttamente la Cloud Function

### Reset Emergenza

Se il sistema è bloccato, puoi aggiornare manualmente Firestore:

```javascript
// Da Firebase Console o Admin SDK
await db.collection('config').doc('system_status').update({
  isReadOnly: false,
  maintenanceMessage: null
});
```

## 📈 Best Practices

### 1. Monitoraggio Continuo
- Imposta alert per costi crescenti (50%, 75%, 90%)
- Monitora regolarmente i log delle Cloud Functions
- Controlla periodicamente lo stato del sistema

### 2. Budget Planning
- Imposta budget realistici basati sull'uso storico
- Considera costi di scaling e picchi di utilizzo
- Mantieni un buffer di sicurezza (20-30%)

### 3. Admin Access
- Limita gli UID admin a personale autorizzato
- Implementa logging per azioni amministrative
- Usa autenticazione a due fattori per admin

### 4. Testing
- Testa regolarmente il sistema di kill switch
- Simula scenari di superamento budget
- Verifica recovery procedures

## 🆘 Troubleshooting

### Cloud Function non si attiva
- Verifica che il budget sia configurato correttamente
- Controlla i log: `firebase functions:log`
- Assicurati che il topic Pub/Sub sia corretto

### App non si disabilita
- Verifica connessione Firestore
- Controlla che il documento `system_status` esista
- Testa la connessione dalla dashboard admin

### Budget alert non arriva
- Verifica configurazione email in Google Cloud
- Controlla che il budget sia attivo
- Testa con soglie più basse (es. 10%)

## 📞 Supporto

Per problemi o domande:
1. Controlla i log delle Cloud Functions
2. Verifica lo stato in Firestore
3. Consulta la documentazione Google Cloud
4. Contatta il team di sviluppo

---

**Nota**: Questo sistema garantisce che l'applicazione si disabiliti automaticamente prima di generare costi eccessivi, proteggendo sia il budget che l'esperienza utente.