# install python
class python_setup {
    case $operatingsystem {
        ubuntu: {
            package { "python-dev":
                ensure => installed
            }
            package { "python-pip":
                ensure => installed,
                require => Package['python-dev']
            }
            package { 'sshpass':
                ensure => installed,
                require => Package['python-pip']
            }
           package { 'ansible':
                ensure => installed,
                provider => pip,
                require => Package['sshpass']
            }
            package { 'gitric':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'fabric':
                ensure => installed,
                provider => pip,
                require => Package['gitric']
            }
            package { 'httpie':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'stormssh':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'airflow':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
        }
    }
}
