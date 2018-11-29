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
PROGRAM_ARGUMENTS=""
PROGRAM_HOME="/opt/$NAME/"
PROGRAM_JAR="$NAME.jar"

LOGFILE="/var/log/$NAME.log"

start() {
    if [ -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
        echo "Starting $NAME..."
        java -jar "$PROGRAM_HOME$PROGRAM_JAR" $PROGRAM_ARGUMENTS > $LOGFILE &
    else
        echo "$NAME already running"
    fi
}

stop() {
    if [ ! -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
        echo "Stopping service..."
        kill -9 `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"`
        echo "$NAME stopped."
    else
        echo "$NAME is not running"
    fi
}

status() {
	if [ ! -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
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
