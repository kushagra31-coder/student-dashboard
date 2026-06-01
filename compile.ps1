# Compile Script for Dynamic JSP Portfolio
# Run this from the portfolio root directory: c:\Users\tomar\Downloads\portfolio

$ErrorActionPreference = "Stop"

$TOMCAT_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 10.1"
$JAVA_HOME = "C:\Program Files\Java\jdk-25"
$PROJECT_ROOT = $PSScriptRoot
$SRC_DIR = "$PROJECT_ROOT\src"
$WEB_DIR = "$PROJECT_ROOT\Studentdashboard"
$CLASSES_DIR = "$WEB_DIR\WEB-INF\classes"
$LIB_DIR = "$WEB_DIR\WEB-INF\lib"

# Build classpath from Tomcat servlet-api + project libs
$CLASSPATH = "$TOMCAT_HOME\lib\servlet-api.jar;$TOMCAT_HOME\lib\jsp-api.jar;$LIB_DIR\mysql-connector-j-9.7.0.jar;$LIB_DIR\jakarta.servlet.jsp.jstl-api-3.0.0.jar;$LIB_DIR\jakarta.servlet.jsp.jstl-3.0.1.jar"

# Ensure classes directory exists
New-Item -ItemType Directory -Force -Path $CLASSES_DIR | Out-Null

# Find all Java source files
$javaFiles = Get-ChildItem -Path $SRC_DIR -Recurse -Filter "*.java" | ForEach-Object { $_.FullName }

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Compiling Java Source Files" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Source Dir  : $SRC_DIR" -ForegroundColor Yellow
Write-Host "Output Dir  : $CLASSES_DIR" -ForegroundColor Yellow
Write-Host "Files found : $($javaFiles.Count)" -ForegroundColor Yellow
Write-Host ""

foreach ($file in $javaFiles) {
    $relativePath = $file.Replace($SRC_DIR + "\", "")
    Write-Host "  Compiling: $relativePath" -ForegroundColor Gray
}

Write-Host ""

# Compile all Java files at once
& "$JAVA_HOME\bin\javac.exe" `
    -cp $CLASSPATH `
    -d $CLASSES_DIR `
    -sourcepath $SRC_DIR `
    -encoding UTF-8 `
    $javaFiles

if ($LASTEXITCODE -eq 0) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  BUILD SUCCESSFUL" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    # Count compiled class files
    $classFiles = Get-ChildItem -Path $CLASSES_DIR -Recurse -Filter "*.class"
    Write-Host "  Generated $($classFiles.Count) class files" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  BUILD FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}
