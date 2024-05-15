@echo off
setlocal

:: Start the first batch file in a new command window
start "VendorA Monitor" cmd /c "monitor.bat"

:: Start the second batch file in another new command window
start "Dashboards" cmd /c "dashboard.bat"

echo Both batch files are running simultaneously.
pause
endlocal
