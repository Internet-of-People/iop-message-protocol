#!/bin/bash

mkdir -p py
protoc homenode2homenode.proto --python_out=py
protoc client2homenode.proto --python_out=py