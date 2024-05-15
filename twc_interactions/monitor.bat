@echo off
setlocal EnableDelayedExpansion

:: Variables
set "NOTEBOOK_DIR=C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"
set "NOTEBOOK_FILE=pull_vendor_api.ipynb"
set "JSON_FILE=vendorA.json"
set "PIPELINE_COMMAND=elyra-pipeline run %NOTEBOOK_DIR%\update_box.pipeline"

:: Change to the notebook directory
cd /d "%NOTEBOOK_DIR%"

:: Calculate initial hash of the JSON file
set "OLD_HASH="
for /f "tokens=*" %%a in ('certutil -hashfile "%JSON_FILE%" SHA256 ^| find /i /v "hash" ^| find /i /v "certutil"') do (
    set "OLD_HASH=!OLD_HASH!%%a"
)

:start_loop
:: Run Jupyter notebook
echo Running the Jupyter Notebook to update JSON...
jupyter nbconvert --ExecutePreprocessor.timeout=600 --to notebook --execute --inplace "%NOTEBOOK_FILE%"

:: Calculate the hash of the JSON file
set "NEW_HASH="
for /f "tokens=*" %%a in ('certutil -hashfile "%JSON_FILE%" SHA256 ^| find /i /v "hash" ^| find /i /v "certutil"') do (
    set "NEW_HASH=!NEW_HASH!%%a"
)

:: Compare hashes
if "!OLD_HASH!" neq "!NEW_HASH!" (
    echo JSON file content has changed. Running Elyra pipeline...
    %PIPELINE_COMMAND%
    set "OLD_HASH=!NEW_HASH!"
) else (
    echo No change detected in JSON file.
)

:: Wait for a while before checking again
timeout /t 30
goto start_loop
