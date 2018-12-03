#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          spring-data-api
# Description:       Gerencia o PROGRAM springdataapi.
### END INIT INFO

# Variáveis de ambiente para configuração do app
#
# DATABASE_HOST=url de conexão com o banco.de dados
# DATABASE_PORT=porta de conexão com o banco de dados
# DATABASE_NAME=nome do banco de dados
# MYSQL_USER=usuario utilizado na conexão com o banco de dados
# MYSQL_PASSWORD=senha do usuario utilizado na conexão com o banco de dados
#
# REDIS_HOST=url de conexão com o servidor do redis
# REDIS_PORT=porta de conexão com o servidor do redis

NAME="spring-data-api"

JVM_ARGS=""
SPRING_PROFILE="-Dspring.profiles.active=prod"
JAR_HOME="/opt/$NAME/"
JAR_FILE="$NAME.jar"

SCRIPT="java $SPRING_PROFILE $JVM_ARGS -jar $JAR_HOME$JAR_FILE $PROGRAM_ARGS"

PIDFILE="/var/run/$NAME.pid"
LOGFILE="/var/log/$NAME.log"

start() {
    if [ -f /var/run/$PIDNAME ] && kill -0 $(cat /var/run/$PIDNAME); then
        echo "Service $NAME already running" >&2
        exit 1
    fi

    echo "Starting $NAME service..." >&2
    local CMD="$SCRIPT &> \"$LOGFILE\" & echo \$!"
    su -c "$CMD" $RUNAS > "$PIDFILE"
    echo 'Service started' >&2
}

stop() {
    if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
        echo "Service $NAME not running" >&2
        exit 1
    fi
    echo "Stopping service..." >&2
    kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
    echo 'Service stopped' >&2
}

status() {
    if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
        echo "Service $NAME not running" >&2
    else
        echo "Service $NAME is not running" >&2
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
esac

exit 0
