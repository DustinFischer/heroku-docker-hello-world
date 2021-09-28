FROM python:3.7-stretch
MAINTAINER Dustin Fischer <duasfi@gmail.com>


ENV LANG="C.UTF-8" \
    IS_DOCKER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
    USER_ID=1000 \
    USER_HOME="/app" \
    VENV="/venv" \
    CODE_DIR="/code"\
    PATH="/venv/bin:/app/.local/bin:$PATH"
#    PATH="/venv/bin:/app/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Setup app user, home dir
RUN /bin/sh -c useradd -c "" --shell /bin/bash -m -d $USER_HOME -u $USER_ID app
USER app

# Setup user virtualenv
# Install latest python packaging tools
RUN python -m venv --system-site-packages $VENV && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir psycopg2-binary~=2.8.0
    chown -R app $VENV


# copy code, set ownership
#COPY --chown=app:app . /code
#WORKDIR /app/code

# Pip install server libs
#RUN pip install -r requirements.txt
ADD docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
