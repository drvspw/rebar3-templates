#!/bin/bash

set -e

CRED_DIR=${HOME}/.aws
CRED_FILE=${CRED_DIR}/credentials
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=

echo "Setting AWS credentials for ${{{app}}_ENV} environment"

## create credentials file and directory
mkdir -p ${CRED_DIR}
if [ -f ${CRED_FILE} ]; then
    rm ${CRED_FILE}
fi


## get the credentials based on XCR_ENV
case ${{{app}}_ENV} in
    dev)
	AWS_ACCESS_KEY_ID=${DEV_AWS_ACCESS_KEY_ID}
	AWS_SECRET_ACCESS_KEY=${DEV_AWS_SECRET_ACCESS_KEY}
	;;

    prod)
	AWS_ACCESS_KEY_ID=${PROD_AWS_ACCESS_KEY_ID}
	AWS_SECRET_ACCESS_KEY=${PROD_AWS_SECRET_ACCESS_KEY}
	;;
esac

echo "[default]" > ${CRED_FILE}
echo "aws_access_key_id=${AWS_ACCESS_KEY_ID}" >> ${CRED_FILE}
echo "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" >> ${CRED_FILE}
