#!/bin/bash

aws lambda invoke --profile prod --region us-west-2 --function-name tf_hello /dev/stdout
