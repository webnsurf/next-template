#! /bin/sh
buildNumber=$BUILD_NUMBER;
environment=$ENVIRONMENT;

timestamp=$(date +'%Y-%m-%d_%H.%M.%S');
projectName="next_template";

if [ "$buildNumber" = "" ]; then
  [ "$2" = "" ] && buildNumber="latest" || buildNumber=$2;
fi;

if [ "$environment" = "" ]; then
  [ "$3" = "" ] && environment="production" || environment=$3;
fi;

image="$projectName:$buildNumber";

echo "\\n|-------------------------------------------------------------------------------------|";
echo "|-------------- Building $projectName image ----------------------------------------------|";
echo "|-------------------------------------------------------------------------------------|";
echo "  Time-------------------| $timestamp";
echo "  Environment:-----------| $environment";
echo "  New Docker Image name:-| $image";
echo "|-------------------------------------------------------------------------------------|";
echo "|-------------------------------------------------------------------------------------|\\n";

docker build . \
  --file "docker/Dockerfile" \
  --build-arg "BUILD_ENV=$environment" \
  --tag $image;
