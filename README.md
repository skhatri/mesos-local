Install mesos

```
brew install mesos
```

Install marathon

```
curl http://downloads.mesosphere.com/marathon/v1.3.5/marathon-1.3.5.tgz
tar zxf marathon-1.3.5.tgz

```

Start Mesos Master

```
/usr/local/sbin/mesos-master --ip=127.0.0.1 --work_dir=/tmp/mesos2 > /tmp/mesos-master.log &
```

Start Mesos-Slave

```
/usr/local/sbin/mesos-slave --master=127.0.0.1:5050 --ip=127.0.0.1 --work_dir=/tmp/mesosworker --executor_registration_timeout=10mins --containerizers=docker,mesos > /tmp/mesosworker.log &

```

The key here is to make sure you have docker in containerizers parameter.


Start Marathon

```
./marathon-1.3.5/bin/start --master localhost:5050  --task_launch_timeout=600000 > /tmp/marathon.log &
```

Similarly, the task launch timeout should be at least same as mesos-slave's executor_registration_timeout

Open http://localhost:5050 to view Mesos master.
Open http://localhost:8080/ui/ to view marathon ui


Sample Docker Application to run two instances

```
{
  "id": "/nodejs-alpine",
  "cmd": null,
  "cpus": 1,
  "mem": 32,
  "disk": 0,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": "skhatri/nodejs-alpine",
      "network": "BRIDGE",
      "portMappings": [
        {
          "containerPort": 0,
          "hostPort": 0,
          "servicePort": 10002,
          "protocol": "tcp",
          "labels": {}
        }
      ],
      "privileged": false,
      "parameters": [],
      "forcePullImage": false
    }
  },
  "healthChecks": [
    {
      "path": "/",
      "protocol": "HTTP",
      "portIndex": 0,
      "gracePeriodSeconds": 300,
      "intervalSeconds": 60,
      "timeoutSeconds": 20,
      "maxConsecutiveFailures": 3,
      "ignoreHttp1xx": false
    }
  ],
  "portDefinitions": [
    {
      "port": 10002,
      "protocol": "tcp",
      "labels": {}
    }
  ]
}
```


Creating App using API

```
curl -H "Content-Type:application/json" -X POST -d @node.json http://localhost:8080/v2/apps
```
