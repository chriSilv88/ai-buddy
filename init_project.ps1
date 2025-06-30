<# init_project.ps1 — создаёт структуру Offline-Ru-Buddy #>
$root = "."
function New-Dir { param($p) if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p | Out-Null } }

# ---------- каталоги --------------------------------------------------
@(
"core/buddy/llm","core/buddy/asr","core/buddy/tts",
"core/buddy/commands","core/buddy/storage",
"core/models","core/data","core/tests",
"desktop/electron/public","desktop/electron/src/components",
"desktop/electron/src/ipc","desktop/dist","desktop/builder",
"scripts","ci","docs"
) | ForEach-Object { New-Dir "$root/$_" }

# ---------- пустые файлы ----------------------------------------------
@(
"core/buddy/__init__.py","core/buddy/core.py",
"core/requirements.txt","core/Dockerfile",
"desktop/electron/package.json","desktop/electron/vite.config.js",
"README.md",".gitignore","Makefile",
"docs/roadmap.md","docs/architecture.drawio","docs/api_openapi.yaml"
) | ForEach-Object { if (-not(Test-Path "$root/$_")) {New-Item -ItemType File -Path "$root/$_" | Out-Null } }

Write-Host "`n✓ Дерево каталогов создано!"