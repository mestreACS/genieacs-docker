#!/bin/sh

set -o allexport # automatically export all variables
source $1
set +o allexport

$($2)