#自用基础镜像
env: centos7 + jdk1.8_181 + nginx1.15.6 (static_gzip)

####build local:
```shell
#pull project
git clone https://github.com/shenzudan/docker-cent7-jdk8-nginx.git
cd docker-cent7-jdk8-nginx

#install docker-ce
bash install_docker.sh

#build dockerfile
docker build -t stanwind/cent7-jdk8-nginx:1.0 .
```

####usage:

local artifacts
```dockerfile
FROM stanwind/cent7-jdk8-nginx:1.0
```

remote artifacts
```dockerfile
FROM registry.cn-shenzhen.aliyuncs.com/stanwind/cent7-jdk8-nginx:1.0
```







