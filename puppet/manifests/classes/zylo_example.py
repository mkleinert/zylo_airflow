from airflow import DAG
from airflow.operators import PythonOperator
from airflow.operators.sensors import HttpSensor
from airflow.hooks.mysql_hook import MySqlHook
from datetime import datetime, timedelta

import requests
import zipfile
import StringIO
import pandas

seven_days_ago = datetime.combine(datetime.today() - timedelta(7),
                                  datetime.min.time())

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': seven_days_ago,
    'email': ['matt.kleinert@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

def get_zip(ds, **kwargs):
#       pprint(kwargs)
#        print(ds)
        r = requests.get('http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip', stream=True)
        z = zipfile.ZipFile(StringIO.StringIO(r.content))
        z.extractall()

def top_teams(ds,**kwargs):
    data = pandas.read_csv('/home/vagrant/airflow/dags/baseballdatabank-master/core/Teams.csv')
    teams = pandas.read_csv('/home/vagrant/airflow/dags/baseballdatabank-master/core/TeamsFranchises.csv')

    data['percentage'] =data['W']/(data['W'] + data['L'])

    data = data.sort(['yearID','percentage'],ascending=False)
    top_teams = data.sort(['yearID','percentage'], ascending=False).groupby('yearID').head(1)
    top_teams = top_teams[['yearID','franchID','teamID','W','L','percentage']]
    top_teams_final = top_teams.merge(teams,on='franchID',how='inner')
    top_teams_final.drop(['active','NAassoc'],axis=1, inplace=True)
    top_teams_final.to_csv('/home/vagrant/airflow/dags/baseballdatabank-master/core/top_teams_final.csv', sep='\t',index=False)

def bulk_load_teams(table_name, **kwargs):
    local_filepath = '/home/vagrant/airflow/dags/baseballdatabank-master/core/top_teams_final.csv'
    conn = MySqlHook(mysql_conn_id='local_mysql')
    #conn.bulk_load(table_name, local_filepath)
    results = pandas.read_csv(local_filepath, sep = '\t',  names=['yearID', 'franchID', 'teamID', 'W', 'L', 'percentage', 'franchName' ], encoding='utf-8')
    conn.insert_rows(table=table_name, rows=results.values.tolist())
    return table_name

dag = DAG('zylo_example',
          schedule_interval=timedelta(hours=1),
          start_date=datetime(2016, 10, 24),
          default_args=default_args)

t1 = PythonOperator(
    task_id='get_zip_file',
    provide_context=True,

    python_callable=get_zip,
    dag=dag)

t2 = PythonOperator(
    task_id='get_top_teams',
    provide_context=True,

    python_callable=top_teams,
    dag=dag)

t3 = PythonOperator(
        task_id='load_to_MySql',
        provide_context=True,
        python_callable=bulk_load_teams,
        op_kwargs={'table_name': 'top_teams'},
        dag=dag)

t2.set_upstream(t1)
t3.set_upstream(t2)