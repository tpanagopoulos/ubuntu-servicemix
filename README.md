# ubuntu-servicemix
A docker image based on Ubuntu running Apache ServiceMix

## Build
docker build -t "ubuntu-smx" .

## Execution
docker run -ti -p 8181:8181 --name smx ubuntu-smx
