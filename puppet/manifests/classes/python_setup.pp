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
                require => Package['python-pip']
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
            package { 'markupsafe':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'sqlalchemy':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'python-dateutil':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'lockfile':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'flask_wtf':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'numpy':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'MySQL-python':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'cython':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            #package { 'pandas':
            #    ensure => installed,
            #    provider => pip,
            #    require => Package['python-pip']
            #}
            package { 'celery':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            package { 'pymysql':
                ensure => installed,
                provider => pip,
                require => Package['python-pip']
            }
            

        }
    }
}
