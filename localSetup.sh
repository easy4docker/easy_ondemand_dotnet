SCR_DIR=$(cd `dirname $0` && pwd)
echo "${SCR_DIR}"

rm -fr ${SCR_DIR}/data
rm -fr ${SCR_DIR}/code

mkdir -p ${SCR_DIR}/data/sitesShareFolder/input
mkdir -p ${SCR_DIR}/data/sitesShareFolder/output
git clone https://github.com/easy4docker/easy_ondemand.git ${SCR_DIR}/code

docker container stop local_ondemand_container
docker container rm local_ondemand_container
docker image rm -f local_ondemand-image

cd ${SCR_DIR}/code/dockerSetting
docker build -f ${SCR_DIR}/code/dockerSetting/dockerFile -t local_ondemand-image .

echo "{\"code_folder\": \"${SCR_DIR}/code/app\", \"data_folder\": \"${SCR_DIR}/data\"}" > ${SCR_DIR}/data/_env.json

docker run -d --rm -v "${SCR_DIR}/data/sitesShareFolder":/var/_sharedFolder \
-v "${SCR_DIR}/code/app":/var/_localApp -v "${SCR_DIR}/data":/var/_localAppData --name local_ondemand_container  local_ondemand-image 

cd ${SCR_DIR}
