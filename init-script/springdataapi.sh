#!/bin/bash
#
### BEGIN INIT INFO
# Provides:          spring-data-api
# Description:       Gerencia o PROGRAM springdataapi.
### END INIT INFO
#
#!/bin/bash
#
# description: Startup script for the PROGRAMlication-load-balancing

# Source function library.

NAME="spring-data-api"

JVM_ARGS=""
JAR_HOME="/opt/$NAME/"
JAR_FILE="$NAME.jar"

LOGFILE="/var/log/$NAME.log"

start() {
    if [ -z `/usr/bin/pgrep -f "java -jar $JAR_HOME$JAR_FILE"` ]; then
        echo "Starting $NAME..."
        java JVM_ARGS -jar "$JAR_HOME$JAR_FILE" > $LOGFILE &
    else
        echo "$NAME already running"
    fi
}

stop() {
    if [ ! -z `/usr/bin/pgrep -f "java -jar $JAR_HOME$JAR_FILE"` ]; then
        echo "Stopping service..."
        kill -9 `/usr/bin/pgrep -f "java -jar $JAR_HOME$JAR_FILE"`
        echo "$NAME stopped."
    else
        echo "$NAME is not running"
    fi
}

status() {
	if [ ! -z `/usr/bin/pgrep -f "java -jar $JAR_HOME$JAR_FILE"` ]; then
       echo "$NAME already running"
    else
        echo "$NAME is not running"
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
