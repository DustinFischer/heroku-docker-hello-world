FROM python:3.7-stretch
MAINTAINER Dustin Fischer <duasfi@gmail.com>


ENV LANG="C.UTF-8" \
    IS_DOCKER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    USER_ID=1000 \
    USER_HOME="/app" \
    VENV="/venv" \
    CODE_DIR="/code"\
    PATH="/venv/bin:/app/.local/bin:$PATH"

# Setup app user, home dir
RUN useradd -c "" --shell /bin/bash -m -d $USER_HOME -u $USER_ID app

# Setup user virtualenv
# Install latest python packaging tools
RUN python -m venv --system-site-packages $VENV && \
    pip install --no-cache-dir --upgrade pip && \
    chown -R app:app $VENV

# copy code, set ownership
COPY --chown=app:app . /code
WORKDIR /code

# Pip install server libs
RUN pip install -r requirements.txt

#Expose the required port
EXPOSE $PORT

USER app
