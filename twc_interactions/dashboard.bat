@echo off
setlocal

:: Set the directory containing the notebooks
set "NOTEBOOK_DIR=C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"

:: Change to the notebook directory
cd /d "%NOTEBOOK_DIR%"

:: Start Voilà for the first notebook on port 8866
start "Volume Report" cmd /c voila "%NOTEBOOK_DIR%\volume_report.ipynb" --port=8866

:: Start Voilà for the second notebook on port 8867
start "CAD Model Update" cmd /c voila "%NOTEBOOK_DIR%\update_cad_model.ipynb" --port=8867

echo Voila servers have been started for both notebooks.
echo Visit http://localhost:8866 for the Volume Report.
echo Visit http://localhost:8867 for the CAD Model Update.
pause
endlocal