# airflow-zylo

* Source code - [Github][10]
* Author - Matt Kleinert - 

[10]: https://github.com/mkleinert/airflow_zylo.git

## About

This project provides a [Ubuntu (14.04)][20] [Vagrant][30] Virtual Machine (VM) with [Airflow][40], a data workflow management system from [Airbnb][50], mySQL Database [mySQL][70], and Python and all the dependecies.

[20]: http://releases.ubuntu.com/14.04/
[30]: http://www.vagrantup.com/
[40]: https://github.com/airbnb/airflow
[50]: http://nerds.airbnb.com/airflow/
[70]: http://www.mysql.com/

There are [Puppet][60] scripts that automatically install the software when the VM is started.

[60]: http://puppetlabs.com/

## Install Vagrant
Vagrant uses Virtualbox to manage the virtual dependencies. You can directly download virtualbox and install or use homebrew for it.
    ```
    $ brew cask install virtualbox
    ```
Now install Vagrant either from the website or use homebrew for installing it.
    ```
    $ brew cask install vagrant
    ```

## Connect to the VM

1. To start the virtual machine(VM) navigate to the location of the Vagrantfile and type

    ```
    vagrant up
    ```

2. Connect to the VM

    ```
    vagrant ssh airflow-zylo
    ```

## Initialize Airflow

1. Setup the home directory

    ```
    export AIRFLOW_HOME=~/airflow
    ```

2. Initialize the sqlite database

    ```
    airflow initdb
    ```

3. Start the web server

    ```
    airflow webserver -p 8080
    ```
4. Start the scheduler by running the following

    ```
    airflow scheduler
    ```

5. Open a web browser to the UI at http://192.168.33.10:8080
    
## Create mySQL table and connection ID

1. Create table
    ```
    mysql -u root -p -e "use airflow_zylo; create table top_teams(yearID int, teamID varchar(24), franchID varchar(24), W int, L int,         percentage varchar(24), franchName varchar(64));"

    Enter password: airflow
    ```
2. Create Connection in Airflow UI.  Go to Admin>Connections> local_mysql Edit
    ```
    Conn Id: local_mysql 
    Conn Type: MySQL 
    Host: localhost 
    Schema: airflow_zylo 
    Login: root 
    Password: airflow 
    Port: '**leave blank**' 
    Extra:  '**leave blank**' 
    ```

## Run a task

1. List DAGS

    ```
    airflow list_dags
    ```
2. Run the zylo_example DAG
    ```
    cd ~
    ```

    ```
    airflow trigger_dag zylo_example
    ```

## Add a new task

1. Go to the Airflow config directory

    ```
    cd ~/airflow
    ```

2. Set the airflow dags directory in airflow.cfg by change the line:

    ```
    dags_folder = /vagrant/airflow/dags
    ```

3. Restart the web server

    ```
    airflow webserver -p 8080
    ```

## Documentation

1. Main documentation

    * https://pythonhosted.org/airflow/

2. Videos on Airflow

    * https://www.youtube.com/watch?v=dgaoqOZlvEA&feature=youtu.be
    * https://www.youtube.com/watch?v=dgaoqOZlvEA

3. Airflow reviews

    * http://bytepawn.com/airflow.html
    * https://www.pandastrike.com/posts/20150914-airflow


## Setup airflow dags directory

1. Edit file ~/airflow/airflow.cfg

2. Set the following:

    ```
    dags_folder = /vagrant/airflow/dags
    load_examples = False
    ```

3. Start the scheduler by running the following

    ```
    airflow scheduler
    ```

## Requirements

The following software is needed to get the software from github and run
Vagrant to set up the Python development environment. The Git environment
also provides an [SSH  client][200] for Windows.

* [Oracle VM VirtualBox][210]
* [Vagrant][220]
* [Git][230]

[200]: http://en.wikipedia.org/wiki/Secure_Shell
[210]: https://www.virtualbox.org/
[220]: http://vagrantup.com/
[230]: http://git-scm.com/
