#!/bin/bash

mkdir -p py
protoc home-node.proto --python_out=py
protoc client.proto --python_out=py