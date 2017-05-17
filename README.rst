Python tools
============

A collection of common scripts used in Python projects

------------------------------------------------------

Example Dockerfile:


.. code-block:: Dockerfile

    FROM mediamoose/uwsgi:latest

    RUN wget https://github.com/mediamoose/python-tools/archive/master.tar.gz -O /dev/stdout | tar -xzv -C /tmp \
     && /tmp/python-tools-*/install.sh django

    ENV DJANGO_COLLECT_STATIC="false" \
        DJANGO_COMPILE_JSI18N="false" \
        DJANGO_COMPILE_MESSAGES="false" \
        DJANGO_MEDIA_ROOT="/project/media" \
        DJANGO_MIGRATE="false" \
        DJANGO_PROJECT_NAME="example_project" \
        DJANGO_SETTINGS_MODULE="main.settings.production" \
        PATH="/usr/python-tools/bin:$PATH" \
        TIMEZONE="Europe/Amsterdam"

    COPY requirements /project/requirements
    RUN pip-install-requirements
