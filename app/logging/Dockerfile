FROM python:3.12-slim-bookworm AS build

# copy uv binary
# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:0.4.1 /uv /bin/uv

COPY . /app

# Sync the project into a new environment, using the frozen lockfile
WORKDIR /app
# uv cache direcotory: https://docs.astral.sh/uv/concepts/cache/#cache-directory
# https://future-architect.github.io/articles/20240726a/
RUN --mount=type=bind,source=uv.lock,target=/app/uv.lock \
    --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

FROM python:3.12-slim-bookworm AS deploy
# Copy source and .venv from builder
COPY --from=build /app /app
WORKDIR /app
# activate virtual environment
ENV PATH=".venv/bin:$PATH"

ENV PORT=8080
ENV LOG_LEVEL=info
ENV WORKERS=1

# FIXME: if execute "pyhton" command, it will be failed.
# docker: Error response from daemon: Conflict. The container name "/api" is already in use by container "860cc1470872c7f99d7202e28de78b9842ff6cc33c2001b9014e332f4477341a". You have to remove (or rename) that container to be able to reuse that name.
CMD [".venv/bin/python", "src/main.py"]
