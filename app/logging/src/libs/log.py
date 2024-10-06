import logging
import os

import google.cloud.logging


def setup_logging():
    # Cloud Run sets these environment variables
    # https://cloud.google.com/run/docs/container-contract#services-env-vars
    if all(e in os.environ for e in ["K_SERVICE", "K_REVISION", "K_CONFIGURATION"]):
        client = google.cloud.logging.Client()
        client.setup_logging(log_level=logging.INFO)
    else:
        logging.basicConfig(
            level=logging.INFO, format="[%(asctime)s][%(name)s][%(levelname)s]: %(message)s"
        )
