# <environment>/manifests/init.pp

node "puppet-agent" {
	include springdataapi
	
	exec { 'apt-update':
		command	=> "/usr/bin/apt-get update",
	}
	
	exec { 'install-redis':
		require	=> Exec['apt-update'],
		command	=> "/usr/bin/apt-get install redis-server -y",
	}
	
	service { 'redis':
		ensure => running,
	}
	
	#Configurando JAVA
	class { 'java':
		distribution => 'jre',
	}
	
	#Configurando mysql
	class { '::mysql::server':
		remove_default_accounts	=> true,
	}
	
	mysql::db { 'mydatabase':
		user			=> 'usuario',
		password		=> 'senha',
		host			=> 'localhost',
		grant			=> ['SELECT', 'CREATE', 'INSERT', 'DROP', 'UPDATE', 'DELETE', 'INDEX'],
		sql				=> '/tmp/schema.sql',
		import_timeout	=> 900,
	}
	
	service { 'mysql':
		ensure => running,
	}
}
