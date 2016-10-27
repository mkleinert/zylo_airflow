#
# puppet magic for dev boxes
#
import "classes/*.pp"

$PROJ_DIR = "/vagrant"
$HOME_DIR = "/home/vagrant"

Exec {
    path => "/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin",
}

node 'airflow-zylo' {
    class {
        init:;
        fzf: ;
        python_setup: require => Class[init];
        gotty: ;
        db: ;
    }
}

