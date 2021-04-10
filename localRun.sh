SCR_DIR=$(cd `dirname $0` && pwd)
echo "${SCR_DIR}"

rm -fr ${SCR_DIR}/data/output

mkdir -p ${SCR_DIR}/data/sitesShareFolder/input
mkdir -p ${SCR_DIR}/data/sitesShareFolder/output

docker container stop local_ondemand_container
docker container rm local_ondemand_container
docker image rm -f local_ondemand-image

cd ${SCR_DIR}/code/dockerSetting
docker build -f ${SCR_DIR}/code/dockerSetting/dockerFile -t local_ondemand-image .

docker run -d --rm -v "${SCR_DIR}/data/sitesShareFolder":/var/_sharedFolder \
-v "${SCR_DIR}/code/app":/var/_localApp -v "${SCR_DIR}/data":/var/_localAppData --name local_ondemand_container  local_ondemand-image 
