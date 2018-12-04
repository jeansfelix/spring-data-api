# <environment>/manifests/site.pp

node "puppet-agent" {
	include springdataapi
	
	exec{ 'create-download-dir':
		command	=> "/bin/mkdir /tmp/downloads",
		creates	=> "/tmp/downloads",
	}
	
	exec{ 'apt-update':
		command	=> "/usr/bin/apt-get update",
	}
	
	exec{ 'install-redis':
		require	=> Exec['apt-update'],
		command	=> "/usr/bin/apt-get install redis-server -y",
	}
	
	service { 'redis':
		ensure => running,
	}
	
	package{ 'mysql-server':
		require	=> Exec['apt-update'],
		ensure	=> installed,
	}
	
	service { 'mysql':
		ensure => running,
	}
}



