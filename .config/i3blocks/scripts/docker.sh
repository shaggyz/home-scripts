#!/usr/bin/env bash

docker ps --format "{{.ID}}" | wc -l
