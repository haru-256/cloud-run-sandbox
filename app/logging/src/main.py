import logging
import os
import time

import uvicorn
from fastapi import FastAPI, Request

from libs.log import setup_logging

setup_logging()
logger = logging.getLogger(__name__)

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.middleware("http")
async def log_requests(request: Request, call_next):
    start_time = time.perf_counter()

    # Log request details
    logger.info(f"Request started: {request.method} {request.url}")
    logger.info(f"Client IP: {request.client.host if request.client else None}")
    logger.info(f"Headers: {request.headers}")

    # Process the request and get the response
    response = await call_next(request)

    # Log response details
    process_time = time.perf_counter() - start_time
    logger.info(f"Request completed: Status {response.status_code}")
    logger.info(f"Process time: {process_time:.5f} seconds")

    return response


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    log_level = os.environ.get("LOG_LEVEL", "info")
    workers = int(os.environ.get("WORKERS", 1))
    uvicorn.run("main:app", host="0.0.0.0", port=port, workers=workers, log_level=log_level)
