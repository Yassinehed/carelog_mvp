# CareLog MVP - Cost Control & Data Governance System

## 🎯 Sistema di Controllo Costi

Questa direttiva implementa un sistema avanzato di controllo costi per proteggere il budget dell'applicazione SaaS.

### 📋 Architettura dei Servizi Dati

- **Cloud Firestore**: Dati operativi real-time e strutturati (Ordini, Segnalazioni, Profili utente)
- **Firebase Storage**: File binari di grandi dimensioni (PDF, immagini)
- **Cloud Functions**: Logica business sicura e automazione

### 🚨 Sistema "Kill Switch" per Budget

Quando il budget Google Cloud raggiunge il 100%, il sistema si attiva automaticamente:

1. **Budget Alert** → Cloud Function attivata via Pub/Sub
2. **Firestore Update** → Documento `/config/system_status` aggiornato
3. **App Disabilitata** → Tutti i controlli di scrittura bloccati lato client
4. **Security Rules** → Blocco server-side delle operazioni di scrittura

### 🔧 Configurazione

#### 1. Setup Cloud Functions
```bash
cd functions
npm install
npm run deploy
```

#### 2. Configurazione Budget Alert
1. Vai su Google Cloud Console → Billing → Budgets
2. Crea un nuovo budget (es. 50€)
3. Aggiungi alert al 100% del budget
4. Configura Pub/Sub topic: `budget-alerts`
5. La Cloud Function `onBudgetExceeded` si attiverà automaticamente

#### 3. Deploy Security Rules
```bash
firebase deploy --only firestore:rules
```

### 📱 Comportamento App

Quando `isReadOnly = true`:
- ✅ **Banner rosso** visibile in cima all'app
- ❌ **Tutti i pulsanti di scrittura** disabilitati con tooltip
- ❌ **Form bloccate** per creazione/modifica
- ❌ **Security Rules** bloccano scritture lato server

### 🔄 Reset Modalità Manutenzione

Per riattivare il sistema (solo admin):
```javascript
// Chiamata Cloud Function
const resetResult = await firebase.functions().httpsCallable('resetReadOnlyMode')();
```

### 📊 Monitoraggio

- **Documento Firestore**: `/config/system_status`
- **Logs Cloud Functions**: Per monitoring budget alerts
- **App Banner**: Indicatore visivo stato sistema

### 🛡️ Sicurezza

- **Server-side enforcement**: Security Rules bloccano sempre le scritture
- **Client-side UX**: UI disabilitata per migliore esperienza utente
- **Audit trail**: Tutti i cambiamenti loggati

### 🚀 Deployment Checklist

- [ ] Cloud Functions deployate
- [ ] Security Rules aggiornate
- [ ] Budget alert configurato
- [ ] Test sistema read-only
- [ ] Documentazione aggiornata

Questo sistema garantisce che l'applicazione SaaS rimanga sempre entro budget proteggendo sia i costi che l'esperienza utente.