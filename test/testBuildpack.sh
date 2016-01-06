#!/bin/bash
echo "***** Starting BW Container Sanity *****"

echo "***** Pushing HTTP Greetings App to CF *****"
URL=`cf push -f manifest.yml | grep "urls:" | cut -d ' ' -f 2`
sleep 5
a=$(curl "http://$URL/greetings/")
BW_MESSAGE=`grep -E "RESPONSE_MESSAGE:" manifest.yml | cut -d ':' -f 2 | tr -d ' ' `
if [ "${a}" = "Greetings from $BW_MESSAGE" ]; then
    echo "----------------------------------------------------------------------";
        echo "******* HTTP Greetings App - running successfully! *******";
     echo "******* HTTP Greetings App - test passed! *******";
    echo "----------------------------------------------------------------------";
else
    echo ${a}
    echo "----------------------------------------------------------------------";
    echo "******* HTTP Greetings App Failed ! Deleting App *******";
    echo "----------------------------------------------------------------------";
    echo "----------------------------------------------------------------------";
    echo "******* bw-buildpack test Failed ! *******";
    echo "----------------------------------------------------------------------";
    cf delete httpapp -f
    exit -1

fi

cf delete httpapp -f