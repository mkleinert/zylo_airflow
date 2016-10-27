# stage {"pre": before => Stage["main"]} class {'apt': stage => 'pre'}

# Commands to run before all others in puppet.
class init {
    group { "puppet":
        ensure => "present",
    }
    case $operatingsystem {
        ubuntu: {
            exec { "update_apt":
                command => "sudo apt-get update",
            }
            
            # Provides "add-apt-repository" command, useful if you need
            # to install software from other apt repositories.
            package { "python-software-properties":
                ensure => present,
                require => Exec['update_apt'];
            }
            package { 'autojump':
                ensure => present,
                require => Exec['update_apt'];
            }
            file { '/etc/profile.d/autojump.sh':
                ensure => present,
                source => '/usr/share/autojump/autojump.sh',
                require => Package['autojump']
            }
            $misc_packages = ['make', 'curl', 'git-core', 'tmux', 'jq',
                'terminator', 'tree', 'silversearcher-ag', 'fonts-inconsolata',
                'vim-gtk','python-mysqldb','python-mako','libffi-dev','libyaml-dev','libssl-dev','python-pandas']
            package { $misc_packages:
                ensure => present,
                require => Exec['update_apt'];
            }
            #file { '/home/vagrant/airflow/dags/':
            #    ensure   => 'present',
            #    source   => 'puppet:///manifests/classes/zylo_example.py',
            #   recurse  => 'true',
            #}
            package { ['build-essential', 'checkinstall']:
                ensure => present,
                require => Exec['update_apt'];
            }
        }
    }
}
