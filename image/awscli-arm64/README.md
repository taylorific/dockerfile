Based on:
https://github.com/aws/aws-cli/blob/v2/docker/Dockerfile
https://hub.docker.com/r/amazon/aws-cli/tags?page=1&ordering=last_updated

docker container run --rm -it \
  -v ~/.aws:/root/.aws \
  -v $(pwd):/aws \
  taylorific/awscli-arm64:latest  
