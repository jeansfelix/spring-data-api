if [ -z $DATABASE_HOST ]; then
	export DATABASE_HOST="localhost" 
fi

if [ -z $DATABASE_PORT ]; then
	export DATABASE_PORT=3306 
fi

if [ -z $DATABASE_NAME ]; then
	export DATABASE_NAME="mydatabase" 
fi

if [ -z $MYSQL_USER ]; then
	export MYSQL_USER="usuario" 
fi

if [ -z $MYSQL_PASSWORD ]; then
	export MYSQL_PASSWORD="senha" 
fi

if [ -z $REDIS_HOST ]; then
	export REDIS_HOST="localhost" 
fi

if [ -z $REDIS_PORT ]; then
	export REDIS_PORT=6379
fi

