@echo off
setlocal EnableDelayedExpansion

:: Variables
set "NOTEBOOK_DIR=C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"
set "NOTEBOOK_FILE=pull_vendor_api.ipynb"
set "JSON_FILE=VendorA.json"
set "PIPELINE_COMMAND=elyra-pipeline run %NOTEBOOK_DIR%\update_box.pipeline"

:: Initialize old hash
set "OLD_HASH="

:loop
:: Change to the notebook directory
cd /d "%NOTEBOOK_DIR%"

:: Run Jupyter notebook
echo Running the Jupyter Notebook to update JSON...
jupyter nbconvert --ExecutePreprocessor.timeout=600 --to notebook --execute --inplace "%NOTEBOOK_FILE%"

:: Calculate the hash of the JSON file
for /F "tokens=* delims=" %%F in ('certutil -hashfile "%JSON_FILE%" SHA256') do (
    set "FILE_HASH=%%F"
    goto check_hash
)

:check_hash
:: Skip the first line which is the certutil output message
if "!FILE_HASH!"=="SHA256 hash of file %JSON_FILE%:" goto loop

:: Check if hash has changed
if not "!OLD_HASH!"=="!FILE_HASH!" (
    set "OLD_HASH=!FILE_HASH!"
    echo JSON file content has changed. Running Elyra pipeline...
    %PIPELINE_COMMAND%
)

:: Wait for a while before checking again
timeout /t 30
goto loop
