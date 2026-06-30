
# ============================================================
#  deploy.ps1 — Full Build + Deploy to Tomcat
#  Run: powershell -ExecutionPolicy Bypass -File .\deploy.ps1
# ============================================================
Write-Host "=== STUDENT DASHBOARD DEPLOY ===" -ForegroundColor Cyan

# 1. Kill Tomcat
Write-Host "[1] Stopping Tomcat..." -ForegroundColor Yellow
Get-Process -Name java -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3

# 2. Maven clean package
Write-Host "[2] Building WAR (mvn clean package)..." -ForegroundColor Yellow
Set-Location $PSScriptRoot
mvn clean package -DskipTests
if ($LASTEXITCODE -ne 0) { Write-Host "BUILD FAILED" -ForegroundColor Red; exit 1 }
Write-Host "Build SUCCESS" -ForegroundColor Green

# 3. Clean Tomcat webapps (keep manager)
$webapps = "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps"
$work    = "C:\Program Files\Apache Software Foundation\Tomcat 10.1\work"
Write-Host "[3] Cleaning old deployment..." -ForegroundColor Yellow
if (Test-Path "$webapps\ROOT")    { Remove-Item -Recurse -Force "$webapps\ROOT" }
if (Test-Path "$webapps\ROOT.war") { Remove-Item -Force "$webapps\ROOT.war" }
if (Test-Path $work) { Remove-Item -Recurse -Force $work }

# 4. Copy new WAR
Write-Host "[4] Deploying ROOT.war..." -ForegroundColor Yellow
Copy-Item -Path "$PSScriptRoot\target\ROOT.war" -Destination "$webapps\ROOT.war" -Force

# 5. Manually extract WAR (faster than waiting for Tomcat auto-expand)
$rootPath = "$webapps\ROOT"
New-Item -ItemType Directory -Path $rootPath -Force | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$webapps\ROOT.war", $rootPath)
Write-Host "WAR extracted." -ForegroundColor Green

# 6. Start Tomcat
Write-Host "[5] Starting Tomcat..." -ForegroundColor Yellow
Start-Process "C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin\startup.bat"
Start-Sleep -Seconds 6

Write-Host "" 
Write-Host "========================================" -ForegroundColor Green
Write-Host "  DEPLOY COMPLETE!" -ForegroundColor Green
Write-Host "  http://localhost:8080/login" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green