class springdataapi {
	file { '/etc/profile.d':
		ensure => directory,
		owner => "root",
		group => "root",
	}

	file { '/etc/profile.d/set-spring-data-api-vars.sh':
		mode => "0644",
		owner => "root",
		group => "root",
		source => "puppet:///modules/springdataapi/set-spring-data-api-vars.sh",
	}
}
