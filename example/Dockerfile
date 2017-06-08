FROM mediamoose/uwsgi:latest

RUN wget https://github.com/mediamoose/python-tools/archive/master.tar.gz -O /dev/stdout | tar -xzv -C /tmp \
 && /tmp/python-tools-*/install.sh django

ENV DJANGO_MEDIA_ROOT="/project/media" \
    DJANGO_PROJECT_NAME="example_project" \
    DJANGO_SETTINGS_MODULE="main.settings.production" \
    PATH="/usr/python-tools/bin:$PATH" \
    TIMEZONE="Europe/Amsterdam"

COPY requirements /project/requirements
RUN pip-install-requirements
