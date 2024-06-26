import time
import subprocess
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from apscheduler.schedulers.background import BackgroundScheduler
import logging

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# User-defined variables
DIRECTORY = r"C:\Users\JohnDeHart\Documents\GitHub\Notebooks\twc_interactions"
JSON_FILE = "vendorA.json"
PIPELINE_FILE = "update_box.pipeline"
MAX_RETRIES = 10
RETRY_DELAY = 5  # seconds

class ChangeHandler(FileSystemEventHandler):
    def __init__(self):
        self.file_changed = False

    def on_modified(self, event):
        if event.src_path == f"{DIRECTORY}\\{JSON_FILE}":
            logging.info(f"File {event.src_path} has been modified")
            self.file_changed = True

def check_and_run_pipeline():
    if event_handler.file_changed:
        event_handler.file_changed = False  # Reset flag to avoid re-triggering during retries
        pipeline_path = f"{DIRECTORY}\\{PIPELINE_FILE}"
        command = ["elyra-pipeline", "run", pipeline_path]
        logging.info(f"Checking existence and attempting to execute command: {' '.join(command)}")

        if os.path.exists(pipeline_path):
            attempt = 0
            while attempt < MAX_RETRIES:
                try:
                    result = subprocess.run(command, capture_output=True, text=True, encoding='utf-8', check=True)
                    logging.info(f"Pipeline executed successfully on attempt {attempt + 1}")
                    if result.stdout:
                        logging.info(f"Pipeline Output: {result.stdout}")
                    if result.stderr:
                        logging.error(f"Pipeline Errors: {result.stderr}")
                    break  # Successful execution, exit the loop
                except subprocess.CalledProcessError as e:
                    logging.error(f"Attempt {attempt + 1}: Pipeline execution failed: {e}")
                except Exception as e:
                    logging.error(f"Attempt {attempt + 1}: Unexpected error: {e}")
                attempt += 1
                if attempt < MAX_RETRIES:
                    logging.info(f"Retrying in {RETRY_DELAY} seconds...")
                    time.sleep(RETRY_DELAY)
        else:
            logging.error(f"Pipeline file not found: {pipeline_path}")
    else:
        logging.info("No changes detected or already processed.")



if __name__ == "__main__":
    event_handler = ChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, DIRECTORY, recursive=True)
    observer.start()

    scheduler = BackgroundScheduler()
    scheduler.add_job(check_and_run_pipeline, 'interval', seconds=10)  # Adjust as needed
    scheduler.start()

    try:
        while True:
            time.sleep(1)
    except (KeyboardInterrupt, SystemExit):
        observer.stop()
        scheduler.shutdown()
    observer.join()