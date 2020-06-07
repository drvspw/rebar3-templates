#!/bin/bash

set -e

VSN=$(~/{{app}}/.package.sh version)
DATA="'{\"attachments\": [{ \"title\": \"Success\",\"text\": \"Built AMI \`{{app}}=${VSN}\` for *${{{app}}_ENV}* environment\",\"color\": \"good\", \"mrkdwn_in\": [\"text\"]}]}'"

echo "curl -X POST -H 'Content-type: application/json' --data ${DATA} ${{{app}}_WEBHOOK_URL}" | /bin/sh
