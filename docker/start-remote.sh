#! /bin/sh
projectName="next_template";
timestamp=$(date +'%Y-%m-%d_%H-%M-%S');
deploymentScriptsFolder="$projectName-deployment-$timestamp";

echo "Create the temporary $projectName deployment scripts...";
echo "\\n|-----------------------------------------------------------------------------------------|"
echo "|-------------- Create the temporary $projectName deployment scripts -------------------------|"
echo "|-----------------------------------------------------------------------------------------|"
echo "  Time------------------------| $timestamp"
echo "  Deployment Scripts Folder:--| $deploymentScriptsFolder"
echo "|-----------------------------------------------------------------------------------------|"
echo "|-----------------------------------------------------------------------------------------|\\n"

mkdir $deploymentScriptsFolder;
cp docker/start.sh $deploymentScriptsFolder/;
cp docker-compose.prod.yml $deploymentScriptsFolder/;

scp -r $deploymentScriptsFolder "next_user@127.0.0.1:$projectName";
rm -r $deploymentScriptsFolder;

ssh next_user@127.0.0.1 "cd $projectName ; ./start.sh $BUILD_NUMBER ; cd .. ; rm -r $projectName";
