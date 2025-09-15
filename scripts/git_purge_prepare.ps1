<#
Script PowerShell: preparazione per la pulizia della storia Git.
Questo script non esegue il push forzato automaticamente. Fa un mirror locale del repo,
esegue git-filter-repo per rimuovere i files indicati, e produce un report.

USO:
1. Installa git-filter-repo (Python) se non presente: python -m pip install --user git-filter-repo
2. Esegui questo script da una directory temporanea (non nella tua working copy):
   .\git_purge_prepare.ps1 -RepoUrl "https://github.com/yourorg/yourrepo.git" -PathsToRemove @("keys/service-account.json.json","keys/service-account.jsonnewedit.json")

Note di sicurezza: lo script non fa push. Dopo verifica manuale puoi eseguire il push forzato:
   git push --force --all
   git push --force --tags

#>
param(
    [Parameter(Mandatory=$true)]
    [string]$RepoUrl,

    [Parameter(Mandatory=$true)]
    [string[]]$PathsToRemove,

    [string]$MirrorDir = "repo-mirror"
)

Write-Host "Mirror clone from $RepoUrl to $MirrorDir"
if(Test-Path $MirrorDir) {
    Write-Host "Directory $MirrorDir esistente. Eliminazione..."
    Remove-Item -Recurse -Force $MirrorDir
}

git clone --mirror $RepoUrl $MirrorDir
if($LASTEXITCODE -ne 0){ Write-Error "git clone fallito"; exit 1 }

Set-Location $MirrorDir

# Costruisci argomenti per filter-repo
$filterArgs = @()
foreach($p in $PathsToRemove){
    $filterArgs += "--path"
    $filterArgs += $p
    $filterArgs += "--invert-paths"
}

Write-Host "Eseguo git-filter-repo con: git filter-repo $($filterArgs -join ' ')"
# Esegui git-filter-repo
git filter-repo @($filterArgs)
if($LASTEXITCODE -ne 0){ Write-Error "git-filter-repo fallito"; exit 2 }

Write-Host "Verifica che i file non siano presenti nella storia:"
foreach($p in $PathsToRemove){
    Write-Host "Controllo: $p"
    git rev-list --all | ForEach-Object { git ls-tree -r $_ } | Select-String $p -Quiet
    if($LASTEXITCODE -eq 0){
        Write-Host "ATTENZIONE: $p appare ancora nella storia"
    } else {
        Write-Host "OK: $p non trovato nella storia"
    }
}

Write-Host "Script terminato. Se tutto OK, eseguire manualmente push forzato dal mirror con:"
Write-Host "git push --force --all"
Write-Host "git push --force --tags"

Write-Host "IMPORTANTE: coordina il team prima del push forzato."
