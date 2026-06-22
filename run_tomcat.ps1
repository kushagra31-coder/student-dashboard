$env:CATALINA_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 10.1"
Write-Host "Starting Apache Tomcat 10.1..." -ForegroundColor Cyan
& "$env:CATALINA_HOME\bin\catalina.bat" run
