from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime
from airflow.models import Variable

dag = DAG('wf-airflow-task-dag', start_date=datetime(1970, 1, 1), schedule_interval=None)

jar = Variable.get('sparkAppJar')
spark_input = Variable.get('sparkInput')
spark_output = Variable.get('sparkOutput')

spark_csv_to_avro_task = BashOperator(
    task_id='spark-csv-to-avro',
    bash_command='spark-submit --master yarn ' + jar + ' ' + spark_input + ' ' + spark_output,
    dag=dag
)

hive_server_url = Variable.get('hiveServerURL')
ddl_location = Variable.get('createTableScriptLocation')

create_table_task = BashOperator(
    task_id='create-hive-table',
    bash_command='beeline -u ' + hive_server_url + ' --hivevar hotelcountslocation=' + spark_output + ' -f ' + ddl_location,
    dag=dag
)

spark_csv_to_avro_task >> create_table_task