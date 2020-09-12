#!/bin/bash
sed "s/tagVersion/$1/g" pods.yml > nodeapp-pod.yml
