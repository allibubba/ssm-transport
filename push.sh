#!/bin/sh
curl --user ${CIRCLECI_CLI_TOKEN}: \
     --request POST \
     --form config=@.circleci/config.yml \
     --form notify=false \
     https://circleci.com/api/v1.1/project/github/circleci/discourse/tree/master
