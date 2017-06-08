#!/bin/ash
set -e
[ $DEBUG ] && set -x

if [ -f /usr/local/assets/entrypoint.sh ];then
    source /usr/local/assets/entrypoint.sh ''
fi

if [[ "$DJANGO_MEDIA_ROOT" ]];then
    mkdir -p $DJANGO_MEDIA_ROOT
    chmod 777 -R $DJANGO_MEDIA_ROOT
fi

if which pre-$1-hook >/dev/null ;then
    echo "Executing 'pre-$1-hook'..."
    pre-$1-hook
fi

while [ "${1:0:2}" == "--" ];do
    cmd=$(echo "$1" | sed -E "s|--([^=]+)=?.*|\1|g")
    val=$(echo "$1" | sed -E "s|--[^=]+=?(.*)|\1|g")
    shift
    if [ "$val" == "false" ];then
        continue
    fi
    if [ "$val" == "true" ];then
        val=''
    fi
    if which $cmd 2>/dev/null &>2;then
        $cmd $val
    fi
done

exec $@
