#!/usr/bin/env pwsh
# ============================================================
#  setup.ps1 - Setup automatico para Windows
#  Uso:  .\setup.ps1
# ============================================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ADK Taller - Setup automatico" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# -- 1. Instalar uv --
Write-Host "[1/5] Verificando uv..." -ForegroundColor Yellow

$uvCmd = Get-Command uv -ErrorAction SilentlyContinue
if ($uvCmd) {
    $uvVersion = & uv --version 2>&1
    Write-Host "  OK uv ya instalado: $uvVersion" -ForegroundColor Green
} else {
    Write-Host "  -> Instalando uv..." -ForegroundColor Yellow
    irm https://astral.sh/uv/install.ps1 | iex
    # Refrescar PATH
    $userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
    $machinePath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')
    $env:Path = $userPath + ';' + $machinePath
    $uvCheck = Get-Command uv -ErrorAction SilentlyContinue
    if (-not $uvCheck) {
        Write-Host "  ERROR: uv no se encontro en PATH despues de instalar." -ForegroundColor Red
        Write-Host "  -> Cierra y vuelve a abrir la terminal, luego ejecuta .\setup.ps1 de nuevo." -ForegroundColor Yellow
        exit 1
    }
    Write-Host "  OK uv instalado correctamente" -ForegroundColor Green
}

# -- 2. Instalar Python 3.12 via uv --
Write-Host ""
Write-Host "[2/5] Verificando Python..." -ForegroundColor Yellow

$ErrorActionPreference = "Continue"
$pythonCheck = & uv python find 3.12 2>&1
$pythonFound = $LASTEXITCODE -eq 0
$ErrorActionPreference = "Stop"

if ($pythonFound) {
    Write-Host "  OK Python 3.12 encontrado: $pythonCheck" -ForegroundColor Green
} else {
    Write-Host "  -> Instalando Python 3.12 via uv..." -ForegroundColor Yellow
    & uv python install 3.12
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ERROR: No se pudo instalar Python 3.12" -ForegroundColor Red
        exit 1
    }
    Write-Host "  OK Python 3.12 instalado" -ForegroundColor Green
}

# -- 3. Crear .venv --
Write-Host ""
Write-Host "[3/5] Creando entorno virtual .venv..." -ForegroundColor Yellow

$venvPython = Join-Path (Join-Path ".venv" "Scripts") "python.exe"

if (Test-Path $venvPython) {
    $venvVersion = & $venvPython --version 2>&1
    Write-Host "  OK .venv ya existe: $venvVersion" -ForegroundColor Green
} else {
    if (Test-Path ".venv") {
        Write-Host "  -> .venv corrupto, recreando..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force ".venv"
    }
    & uv venv --python 3.12
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ERROR: No se pudo crear .venv" -ForegroundColor Red
        exit 1
    }
    Write-Host "  OK .venv creado con Python 3.12" -ForegroundColor Green
}

# -- 4. Instalar dependencias en .venv --
Write-Host ""
Write-Host "[4/5] Instalando dependencias en .venv..." -ForegroundColor Yellow
& uv sync
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: Fallo al instalar dependencias" -ForegroundColor Red
    exit 1
}
Write-Host "  OK google-adk instalado en .venv" -ForegroundColor Green

# -- 5. Verificar .env --
Write-Host ""
Write-Host "[5/5] Verificando configuracion..." -ForegroundColor Yellow

if (Test-Path ".env") {
    $envContent = Get-Content ".env" -Raw
    if ($envContent -match "GOOGLE_API_KEY=AIza") {
        Write-Host "  OK .env configurado con API Key" -ForegroundColor Green
    } else {
        Write-Host "  !! .env existe pero falta GOOGLE_API_KEY" -ForegroundColor Yellow
        Write-Host "     -> Edita .env y agrega tu API Key de aistudio.google.com" -ForegroundColor Yellow
    }
} else {
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
    } else {
        Set-Content -Path ".env" -Value "# Obtener en: https://aistudio.google.com`nGOOGLE_API_KEY="
    }
    Write-Host "  !! Archivo .env creado. Agrega tu API Key:" -ForegroundColor Yellow
    Write-Host "     -> Abre .env y pega tu GOOGLE_API_KEY" -ForegroundColor Yellow
    Write-Host "     -> Obtener gratis en: https://aistudio.google.com" -ForegroundColor Yellow
}

# -- Verificacion final --
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Verificacion final" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$pyVer = & $venvPython --version 2>&1
Write-Host "  Python:     $pyVer" -ForegroundColor White

$adkVer = & uv run python -c "import google.adk; print(google.adk.__version__)" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "  google-adk: v$adkVer" -ForegroundColor White
} else {
    Write-Host "  google-adk: instalado" -ForegroundColor White
}

$uvVer = & uv --version 2>&1
Write-Host "  uv:         $uvVer" -ForegroundColor White

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Setup completado!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Siguientes pasos:" -ForegroundColor Cyan
Write-Host "  1. Agrega tu API Key en .env" -ForegroundColor White
Write-Host "  2. Ejecuta:  uv run adk web ." -ForegroundColor White
Write-Host "  3. Abre:     http://localhost:8000" -ForegroundColor White
Write-Host ""
