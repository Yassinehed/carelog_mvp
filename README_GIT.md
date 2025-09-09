README: Collegare il progetto a GitHub e mettere in sicurezza il repository

Breve piano
- Inizializzare il repository locale (se non già fatto).
- Creare un repository privato su GitHub e pushare il codice.
- Aggiungere i segreti necessari nelle GitHub Actions Secrets.
- Abilitare protezioni sul branch `main` (require PR, require status checks).
- Testare CI con un PR/push.

Prerequisiti consigliati
- Git installato e configurato (nome/email).
- (Opzionale ma comodo) GitHub CLI (`gh`) autenticata.
- Account GitHub con permessi per creare repo e impostazioni.

1) INIZIALIZZARE E PUSHARE IL REPO
Se non hai ancora un repository git locale, esegui:

```powershell
# dalla root del progetto
git init
git add .
git commit -m "Initial commit - CareLog MVP"
# Rinomina branch principale in 'main'
git branch -M main
# Aggiungi remote (sostituisci USERNAME e REPO)
git remote add origin git@github.com:USERNAME/REPO.git
# oppure HTTPS
# git remote add origin https://github.com/USERNAME/REPO.git
# Pusha il contenuto
git push -u origin main
```

Se usi GitHub CLI puoi creare e pushare tutto in un colpo:

```powershell
# crea repo privato e push
gh repo create USERNAME/REPO --private --source=. --remote=origin --push
```

2) AGGIUNGERE I SEGRETI (GH ACTIONS SECRETS)
Aggiungi i seguenti secret via GitHub UI (Settings → Secrets → Actions) o con `gh`:

Segreti consigliati da aggiungere
- FIREBASE_TOKEN — token per deploy (opzionale, `firebase login:ci`).
- FIREBASE_SERVICE_ACCOUNT — (opzionale) JSON del service account (consigliato salvare come base64 e usare in CI).
- RECAPTCHA_SITE_KEY — chiave client per App Check (web).
- RECAPTCHA_SECRET (se necessario lato server).
- OTHER_SECRETS — qualsiasi chiave API sensibile.

Esempio `gh` (sostituisci il valore):

```powershell
# esempio: aggiunge FIREBASE_TOKEN
gh secret set FIREBASE_TOKEN --body "<FIREBASE_TOKEN_VALUE>"
# per un JSON di service account (preferibile: base64)
$sa = Get-Content 'path\to\service-account.json' -Raw | Out-String
gh secret set FIREBASE_SERVICE_ACCOUNT --body $sa
```

3) IMPOSTARE BRANCH PROTECTION (raccomandato)
Imposta protezione su `main` (Settings → Branches → Add rule):
- Require pull request reviews before merging (1+) 
- Require status checks to pass before merging: seleziona i workflow principali (es. `analyze-test`, `build-web`, `build-android`).
- Require linear history (opzionale) 
- Include administrators (opzionale, per maggiore sicurezza)

4) TESTARE CI
- Crea una branch, fai una piccola modifica e apri una Pull Request verso `main`.
- Verifica che i workflow (`flutter_ci.yml`, `codeql-analysis.yml`) siano eseguiti automaticamente.

5) AZIONI POST-COLLEGAMENTO (raccomandate)
- Aggiungi le chiavi SHA1/sha256 per Android nella console Firebase (per App Check/Google Sign-In).
- Configura reCAPTCHA site key nella console Firebase App Check.
- Abilita App Check enforcement su Firestore/Storage solo dopo aver verificato che i client legittimi funzionino correttamente.
- Attiva Dependabot alerts e security updates (Settings → Security).

6) NOTE SULLA SICUREZZA E BUONE PRATICHE
- Non committare mai file contenenti credenziali.
- Usa secrets di GitHub Actions per deployment e rotali regolarmente.
- Limitare il numero di amministratori sul progetto GitHub.
- Testare le Security Rules di Firestore con il Rules Unit Testing.

Se vuoi, posso generare i comandi precisi per:
- creare il token `FIREBASE_TOKEN` (come generarlo),
- convertire un JSON service-account in base64 e aggiungerlo come secret,
- script PowerShell per automatizzare il push e la creazione del repo tramite `gh`.

Quando sei pronto, procedi con il push. Dopo il primo push posso guidarti attraverso la verifica dei workflow e l'aggiunta dei segreti necessari per il deploy e App Check.
