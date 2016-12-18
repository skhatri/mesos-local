
/usr/local/sbin/mesos-master --ip=127.0.0.1 --work_dir=/tmp/mesos2 > /tmp/mesos-master.log &
/usr/local/sbin/mesos-slave --master=127.0.0.1:5050 --ip=127.0.0.1 --work_dir=/tmp/mesosworker --executor_registration_timeout=10mins --containerizers=docker,mesos > /tmp/mesosworker.log & 
$MARATHON_BIN/start --master localhost:5050 --zk zk://localhost:2181/marathon --task_launch_timeout=600000 > /tmp/marathon.log &

