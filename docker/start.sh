#! /bin/sh
buildNumber=$BUILD_NUMBER;
environment=$ENVIRONMENT;
projectDomain="webnsurf.com"

timestamp=$(date +'%Y-%m-%d_%H.%M.%S')
projectName="next_template";

if [ "$buildNumber" = "" ]; then
  [ "$1" = "" ] && buildNumber="latest" || buildNumber=$1;
fi;

if [ "$environment" = "" ]; then
  [ "$2" = "" ] && environment="production" || environment=$2;
fi;

if [ "$environment" = "production" ]; then
  hostRule="Host(\`next.$projectDomain\`)"
  redirect="full-strip-slash@file, full-redirect@file"
else
  hostRule="Host(\`next.$environment.$projectDomain\`)"
  redirect="https-strip-slash@file, https-redirect@file"
fi;

image="$projectName:$buildNumber"

echo "\\n|-----------------------------------------------------------------------------------------|"
echo "|-------------- Starting $projectName containers --------------------------------------------|"
echo "|-----------------------------------------------------------------------------------------|"
echo "  Time------------------------| $timestamp"
echo "  Environment:----------------| $environment"
echo "  Docker Image name:----------| $image"
echo "  Host Rule:------------------| $hostRule"
echo "  Redirect:-------------------| $redirect"
echo "|-----------------------------------------------------------------------------------------|"
echo "|-----------------------------------------------------------------------------------------|\\n"

export COMPOSE_IMAGE="$image"
export COMPOSE_REDIRECT_STRATEGY="$redirect"
export COMPOSE_ROUTER_HOST="$hostRule"

docker-compose -f docker-compose.prod.yml up -d
