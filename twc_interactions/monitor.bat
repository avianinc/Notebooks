@echo off
setlocal EnableDelayedExpansion

:: Variables
set "DIRECTORY=C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"
set "FILE=vendorA.json"
set "COMMAND=elyra-pipeline run %DIRECTORY%\update_box.pipeline"
set "MAX_RETRIES=10"
set "RETRY_DELAY=5"

:: Initial file state capture
set "OLD_SIZE=0"
for /F "usebackq" %%I in (`powershell -Command "(Get-Item '%DIRECTORY%\%FILE%').length"` ) do set "OLD_SIZE=%%I"

:loop
timeout /t 10

:: Check file size for changes
set "NEW_SIZE=0"
for /F "usebackq" %%I in (`powershell -Command "(Get-Item '%DIRECTORY%\%FILE%').length"` ) do set "NEW_SIZE=%%I"

:: Compare sizes
if !OLD_SIZE! NEQ !NEW_SIZE! (
    set "OLD_SIZE=!NEW_SIZE!"
    echo File has changed. Attempting to run command...
    call :execute_command
) else (
    echo No changes detected.
)

goto loop

:execute_command
set /a "RETRY_COUNT=0"

:retry_logic
if !RETRY_COUNT! lss %MAX_RETRIES% (
    %COMMAND%
    if !ERRORLEVEL! EQU 0 (
        echo Command executed successfully.
    ) else (
        echo Failed to execute command. Retrying...
        set /a "RETRY_COUNT+=1"
        timeout /t %RETRY_DELAY%
        goto retry_logic
    )
)
exit /b
