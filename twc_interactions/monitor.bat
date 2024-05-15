@echo off
setlocal EnableDelayedExpansion

:: Variables
set "NOTEBOOK_DIR=C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"
set "NOTEBOOK_FILE=pull_vendor_api.ipynb"
set "JSON_FILE=VendorA.json"
set "PIPELINE_COMMAND=elyra-pipeline run %NOTEBOOK_DIR%\update_box.pipeline"
set "CHECK_INTERVAL=300"  :: Check interval in seconds, e.g., 300 seconds = 5 minutes

:: Get initial last modification time
for /F "delims=" %%I in ('powershell -command "(Get-Item '%NOTEBOOK_DIR%\%JSON_FILE%').LastWriteTime.ToString('yyyyMMddHHmmss')"') do set "LAST_MOD_TIME=%%I"

:loop
:: Execute the Jupyter notebook
echo [%TIME%] Running the Jupyter Notebook...
jupyter nbconvert --ExecutePreprocessor.timeout=600 --to notebook --execute --inplace "%NOTEBOOK_DIR%\%NOTEBOOK_FILE%"

:: Check if the JSON file was updated
for /F "delims=" %%I in ('powershell -command "(Get-Item '%NOTEBOOK_DIR%\%JSON_FILE%').LastWriteTime.ToString('yyyyMMddHHmmss')"') do set "NEW_MOD_TIME=%%I"

:: Compare modification times
if "!NEW_MOD_TIME!" NEQ "!LAST_MOD_TIME!" (
    echo [%TIME%] JSON file was updated. Running Elyra pipeline...
    %PIPELINE_COMMAND%
    set "LAST_MOD_TIME=!NEW_MOD_TIME!"
) else (
    echo [%TIME%] No changes detected in JSON file.
)

:: Wait for the next check
timeout /t %CHECK_INTERVAL%
goto loop
