#!/bin/bash

set -e

kops delete cluster --name $1 --yes