import os
import re
import csv

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
LIB = os.path.join(ROOT, 'lib')
OUT = os.path.join(ROOT, 'docs', 'string_inventory_2024.csv')

string_pattern = re.compile(r'''("(?:\\.|[^"\\])*")|('(?:\\.|[^'\\])*')''')

block_comment = re.compile(r'/\*.*?\*/', re.DOTALL)
line_comment = re.compile(r'//.*')

img_ext = re.compile(r".*\.(png|jpg|jpeg|gif|svg)$", re.IGNORECASE)

rows = []
file_count = 0
string_count = 0

for dirpath, dirnames, filenames in os.walk(LIB):
    for fname in filenames:
        if not fname.endswith('.dart'):
            continue
        file_count += 1
        fpath = os.path.join(dirpath, fname)
        try:
            with open(fpath, 'r', encoding='utf-8') as f:
                text = f.read()
        except Exception as e:
            print('SKIP', fpath, e)
            continue

        # Remove block and line comments (simple heuristics)
        text_nocomments = block_comment.sub('', text)
        text_nocomments = line_comment.sub('', text_nocomments)

        # Iterate lines to get line numbers and context
        lines = text.splitlines()
        for i, line in enumerate(lines, start=1):
            # skip imports
            if line.strip().startswith('import'):
                continue
            for m in string_pattern.finditer(line):
                literal = m.group(0)
                # strip surrounding quotes
                content = literal[1:-1]
                # Exclude asset paths
                if 'assets/' in content or img_ext.match(content):
                    continue
                # Exclude empty strings
                if content.strip() == '':
                    continue
                # Determine category
                cat = 'INTERNAL'
                # If contains space or punctuation likely UI
                if re.search(r'\s', content) or re.search(r'[\.,!?:;\-\(\)]', content):
                    cat = 'UI_VISIBLE'
                # If path-like or route
                if content.startswith('/') or '/' in content:
                    cat = 'KEYS'
                # If looks like a key (snake_case, no spaces)
                if re.match(r'^[a-z0-9_\\-]+$', content) and len(content) < 60:
                    # prefer KEYS for short tokens
                    cat = 'KEYS'
                # If looks like a message with spaces, force UI
                if re.search(r'\s', content):
                    cat = 'UI_VISIBLE'

                # Surrounding code: 20 chars before and after in the original file text
                # Find position of literal in the full text to capture context
                # We'll try to find this occurrence by searching the line substring
                start = max(0, m.start() - 20)
                before = line[max(0, m.start()-20):m.start()]
                after = line[m.end(): m.end()+20]
                surrounding = (before + literal + after).strip()

                rows.append([os.path.relpath(fpath, ROOT), i, content.replace('\n', '\\n').replace('\r',''), cat, surrounding])
                string_count += 1

# Ensure docs dir exists
os.makedirs(os.path.join(ROOT, 'docs'), exist_ok=True)

with open(OUT, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['filepath','line_number','string_content','category','surrounding_code'])
    for r in rows:
        writer.writerow(r)

print(f'FILES={file_count} STRINGS={string_count} OUTPUT={OUT}')
