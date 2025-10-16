import os
import re
from shutil import move

repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
docs_csv = os.path.join(repo_root, 'docs', 'string_inventory_2024.csv')
secrets_dir = os.path.join(repo_root, '.secrets')
raw_csv = os.path.join(secrets_dir, 'string_inventory_2024_raw.csv')

if not os.path.exists(docs_csv):
    print('CSV not found:', docs_csv)
    raise SystemExit(1)

os.makedirs(secrets_dir, exist_ok=True)

# Move original to .secrets as raw backup
move(docs_csv, raw_csv)
print('Moved original CSV to', raw_csv)

# Read raw and redact
with open(raw_csv, 'r', encoding='utf-8') as f:
    lines = f.readlines()

redacted = []
api_re = re.compile(r"AIza[0-9A-Za-z-_]{35}")
for ln in lines:
    # redact API keys in the line
    newln = api_re.sub('[REDACTED_API_KEY]', ln)
    # also redact any long-looking tokens (heuristic)
    newln = re.sub(r"[A-Za-z0-9-_]{40,}", '[REDACTED]', newln)
    redacted.append(newln)

# Write redacted CSV back to docs
with open(docs_csv, 'w', encoding='utf-8') as f:
    f.writelines(redacted)

print('Wrote redacted CSV to', docs_csv)
print('Done')
