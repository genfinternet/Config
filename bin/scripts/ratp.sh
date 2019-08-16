#!/bin/bash

curl http://api-ratp.pierre-grimaud.fr/v2/bus/125/stations/1642?destination=72 \
2>/dev/null | jq ".response.schedules[] | .message" | head -n 2 | sed -e "s/\"//g"
