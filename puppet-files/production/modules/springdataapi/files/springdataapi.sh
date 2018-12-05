#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          spring-data-api
# Description:       Gerencia o PROGRAM springdataapi.
### END INIT INFO

# Variáveis de ambiente para configuração do app
#
#DATABASE_HOST="localhost"
#DATABASE_PORT="3306"
#DATABASE_NAME="mydatabase"
#MYSQL_USER="usuario"
#MYSQL_PASSWORD="senha"
#REDIS_HOST="localhost"
#REDIS_PORT="6379"
#TOMCAT_PORT="8443"
#TOMCAT_COMPRESSION_ENABLED="true"
#TOMCAT_COMPRESSION_MIN_RESPONSE_SIZE="2MB"
#TOMCAT_ACCEPT_COUNT="200"
#TOMCAT_MAX_CONNECTIONS="20000"
#TOMCAT_MAX_THREADS="200"
#TOMCAT_MIN_SPARE_THREADS="10"
#TOMCAT_MAX_HTTP_POST_SIZE="2MB"
#TOMCAT_MAX_SWALLOW_SIZE="2MB"

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
