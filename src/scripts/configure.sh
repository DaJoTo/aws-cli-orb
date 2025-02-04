#!/bin/sh
if cat /etc/issue | grep "Alpine" >/dev/null 2>&1; then
    . $BASH_ENV
fi

PARAM_AWS_CLI_ACCESS_KEY_ID=$(eval echo "\$$PARAM_AWS_CLI_ACCESS_KEY_ID")
PARAM_AWS_CLI_SECRET_ACCESS_KEY=$(eval echo "\$$PARAM_AWS_CLI_SECRET_ACCESS_KEY")
PARAM_AWS_CLI_REGION=$(eval echo "\$$PARAM_AWS_CLI_REGION")

if [ -z "$PARAM_AWS_CLI_ACCESS_KEY_ID" ] || [ -z "${PARAM_AWS_CLI_SECRET_ACCESS_KEY}" ]; then 
    echo "Cannot configure profile. AWS access key id and AWS secret access key must be provided."
    exit 1
fi

aws configure set aws_access_key_id \
    "$PARAM_AWS_CLI_ACCESS_KEY_ID" \
    --profile "$PARAM_AWS_CLI_PROFILE_NAME"

aws configure set aws_secret_access_key \
    "$PARAM_AWS_CLI_SECRET_ACCESS_KEY" \
    --profile "$PARAM_AWS_CLI_PROFILE_NAME"

if [ -n "${AWS_SESSION_TOKEN}" ]; then
    aws configure set aws_session_token \
        "${AWS_SESSION_TOKEN}" \
        --profile "$PARAM_AWS_CLI_PROFILE_NAME"
fi

if [ "$PARAM_AWS_CLI_CONFIG_DEFAULT_REGION" = "1" ]; then
    aws configure set default.region "$PARAM_AWS_CLI_REGION" \
        --profile "$PARAM_AWS_CLI_PROFILE_NAME"
fi

if [ "$PARAM_AWS_CLI_CONFIG_PROFILE_REGION" = "1" ]; then
    aws configure set region "$PARAM_AWS_CLI_REGION" \
        --profile "$PARAM_AWS_CLI_PROFILE_NAME"
fi
