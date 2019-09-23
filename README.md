
Build locally

```
export DOCKER_USER=gulli
./build-docker.sh
```


Running

```
docker run -e DOCKER_USER=YourDockerUserName  -v $HOME/.aws:/home/deployeruser/.aws $DOCKER_USER/cicdw-myip-api master 

```


Running unit tests


```
docker run -v $(pwd):/home/deployeruser -it gulli/cloudformation-deployer /bin/bash

npm ci
npm run test

```
