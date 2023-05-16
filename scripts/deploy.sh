#!/bin/bash
oc project wbc9 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mqcl2

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mqcl2route
oc delete secret mqcl2key
oc delete configMap cl2-mqsc
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mqcl2Route.yaml
oc create secret tls mqcl2key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
