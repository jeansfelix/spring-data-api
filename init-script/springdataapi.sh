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

PROGRAM_ARGUMENTS=""
PROGRAM_HOME="/opt/spring-data-api/"
PROGRAM_JAR="springdataapi.jar"
PROGRAM_NAME="spring-data-api"

start() {
    if [ -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
        echo "Starting $PROGRAM_NAME..."
        cd ${ALB_HOME}

        java -jar "$PROGRAM_HOME$PROGRAM_JAR" ${PROGRAM_ARGUMENTS} &
    else
        echo "$PROGRAM_NAME is already running"
    fi
}

stop() {
    if [ ! -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
        echo "Stopping service..."
        kill -9 `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"`
        echo "$PROGRAM_NAME stopped."
    else
        echo "$PROGRAM_NAME is not running"
    fi
}

status() {
	if [ ! -z `/usr/bin/pgrep -f "java -jar $PROGRAM_HOME$PROGRAM_JAR"` ]; then
       echo "$PROGRAM_NAME is running"
    else
        echo "$PROGRAM_NAME is not running"
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
