class db {
exec { "system-update":
        command => "zypper update -y",
        onlyif => "test $(facter uptime_seconds) -lt 300",
}

$mysql_password = "airflow"
$db_name = "airflow_zylo"
$db_user = "airflow"
$db_pass = "airflow"
$db_access = "192.168.33.%"

class { '::mysql::server':
  root_password    => $mysql_password,
  override_options => { 'mysqld' => { 'bind-address' => $ipaddress_eth0 } }
}

mysql::db { $db_name :
  user     => $db_user,
  password => $db_pass,
  host     => $db_access,
  grant  => 'ALL',
}
}