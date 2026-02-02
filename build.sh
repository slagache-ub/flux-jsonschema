#!/bin/bash

# Derived from https://github.com/yannh/kubernetes-json-schema/blob/7b175a3e9dc7ca8235439a0cc222bf9e2532ff15/build.sh

OPENAPI2JSONSCHEMABIN="./venv/bin/python src/openapi2jsonschema.py"
CONFIGPARSERBIN="./venv/bin/python src/config_parser.py"
RESOURCES=$($CONFIGPARSERBIN list config.yaml)

for RESOURCE in $RESOURCES; do
  GIT_REPO=$($CONFIGPARSERBIN get -n $RESOURCE -k repo config.yaml)
  VERSION_PATTERN=$($CONFIGPARSERBIN get -n $RESOURCE -k version config.yaml)
  VERSIONS=$(git ls-remote --refs --tags $GIT_REPO | cut -d/ -f3 | grep -e $VERSION_PATTERN)
  for VERSION in $VERSIONS; do
    TEMPLATE=$($CONFIGPARSERBIN get -n $RESOURCE -k crds config.yaml)
    CRDS_URL=$(echo $TEMPLATE | sed "s/{version}/$VERSION/")
    $OPENAPI2JSONSCHEMABIN -o $RESOURCE/$VERSION $CRDS_URL
  done
done