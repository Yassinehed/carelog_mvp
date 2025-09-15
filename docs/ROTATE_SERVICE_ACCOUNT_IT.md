# Guida: Revoca e rotazione di una Service Account Firebase (italiano)

Questo documento descrive i passi immediati per trattare una service account le cui credenziali (file JSON) sono state esposte in un repository.

Obiettivo rapido
- Revocare la chiave esposta (mark as compromised).
- Creare una nuova chiave se necessario.
- Spostare la nuova chiave in un Secret Manager o in segreti CI (non nel repo).
- Aggiornare i servizi/CI che dipendono dalla chiave.

Prerequisiti
- Permessi su GCP: Owner o IAM Admin / Service Account Admin per il progetto `carelog-mv`.
- Accesso alla Google Cloud Console per il progetto interessato.

1) Revoca della chiave compromessa (passo urgente)
- Vai su: https://console.cloud.google.com/iam-admin/serviceaccounts?project=carelog-mv
- Trova la service account con `client_email` che corrisponde a `firebase-adminsdk-...@carelog-mv.iam.gserviceaccount.com`.
- Clicca sulla service account -> tab "Keys" (Chiavi).
- Individua la chiave con `private_key_id` corrispondente (se lo sai) e clicca su *Delete* o *Revoke key*.
- Conferma la cancellazione.

Nota: se non sei sicuro quale chiave sia stata esposta, elimina tutte le chiavi esistenti per quella service account e poi crea una nuova (vedi passo 2).

2) Creare una nuova chiave (se necessaria)
- Nella stessa pagina -> tab "Keys" -> *Add Key* -> *Create new key* -> scegli formato JSON -> *Create*.
- Scarica il file JSON generato e trasferiscilo immediatamente in modo sicuro (non committarlo):
  - Preferibilmente caricalo su GCP Secret Manager, oppure in un Secret store del tuo provider CI (GitHub Actions Secrets, GitLab CI variables, Azure Key Vault).
  - Se usi GitHub Actions: converti il JSON in Base64 e salva il valore come segreto (es. `GCP_SA_BASE64`).

3) Usare GCP Secret Manager (raccomandato)
- Vai su: https://console.cloud.google.com/security/secret-manager?project=carelog-mv
- *Create Secret* -> Nome: `carelog-mv/service-account` (o schema simile) -> Carica il contenuto JSON.
- Imposta IAM del segreto: concedi accesso solo ai servizi/identità che ne hanno bisogno (principio del minor privilegio).

4) Aggiornare CI / deploy
- GitHub Actions (esempio):
  - Carica il secret `GCP_SA_BASE64` su GitHub repository Settings -> Secrets -> Actions.
  - Nel workflow, decodifica e usa il file temporaneo:

```yaml
- name: Decode GCP SA
  run: echo "$GCP_SA_BASE64" | base64 --decode > /tmp/gcp-sa.json
- name: Authenticate
  uses: google-github-actions/auth@v1
  with:
    credentials_json: /tmp/gcp-sa.json
```

- Se usi altri provider CI, carica il file nel vault corrispondente e aggiorna i job.

5) Rimuovere ogni copia residua e bloccare commit futuri
- Assicurati che la directory `keys/` sia in `.gitignore` (già presente in questo repo).
- Elimina file locali sensibili e non committarli mai più.

PowerShell (comandi locali) per rimozione immediata
```powershell
# rimuove file dall'indice git (se ancora tracciato) e dalla working tree
git rm --cached --ignore-unmatch keys/service-account.json.json
git rm --cached --ignore-unmatch keys/service-account.jsonnewedit.json
Remove-Item -Path .\keys\service-account.json.json -Force -ErrorAction SilentlyContinue
Remove-Item -Path .\keys\service-account.jsonnewedit.json -Force -ErrorAction SilentlyContinue
```

6) Audit e monitoraggio
- Dopo la revoca, controlla IAM audit logs e i log di billing per attività sospette.
- Log GCP: https://console.cloud.google.com/logs/query?project=carelog-mv
- Cerca attività autenticata dal `client_email` della service account.

7) Hardening e best practices
- Usa Secret Manager o variabili CI, non file nel repo.
- Applica principio del minor privilegio: assegna solo le role necessarie al service account (es. Storage Admin solo se serve).
- Considera l'uso di workload identity ove possibile (es. per GKE).

Se vuoi posso automatizzare la parte di caricamento nel Secret Manager e l'aggiornamento dei workflow GitHub (preparare PR con i cambiamenti necessari).
