import csv
from pathlib import Path
p=Path('docs/string_inventory_2024.csv')
rows=[]
with p.open(encoding='utf-8',newline='') as f:
    r=csv.reader(f)
    header=next(r)
    for row in r:
        s=row[2]
        if 'AIza' in s or (len(s)>80 and any(c.isalnum() for c in s)):
            row[3]='SENSITIVE'
        rows.append(row)
with p.open('w',encoding='utf-8',newline='') as f:
    w=csv.writer(f)
    w.writerow(header)
    w.writerows(rows)
print('Sanitized')
