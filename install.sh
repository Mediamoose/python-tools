#!/bin/ash
set -e

rm -rf /usr/python-tools

mv $(dirname $0)/python-tools /usr/python-tools
rm -rf $(dirname $0)

if [ -e "/usr/python-tools/$1/entrypoint.sh" ];then
    ln -sf /usr/python-tools/$1/entrypoint.sh /docker-entrypoint.sh
fi

if [ -d "/usr/python-tools/$1/bin" ];then
    for file in $(ls "/usr/python-tools/$1/bin");do
        ln -sf "../$1/bin/$file" "/usr/python-tools/bin/$file"
    done
fi

source /etc/os-release

# Add celery user
if [ "$ID" == "alpine" ];then
    adduser -D -g='' celery
else
    adduser --disabled-password --gecos '' celery
fi
