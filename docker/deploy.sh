#! /bin/sh

projectName="next_template";

image="$projectName:$BUILD_NUMBER";

echo "Zipping up and transfering $projectName image...";
docker save "$image" | bzip2 | pv | ssh next_user@127.0.0.1 "bunzip2 | docker load";

echo "Removing $projectName production image from staging server...";
docker image rm "$image";
