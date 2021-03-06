#!/bin/bash

ajv compile -s "schemas/*/*.json" -r "schemas/*/*.json" -c ajv-formats-draft2019 --verbose
protocol_validator --schemas `pwd`/schemas -r examples --strict --ignore 302
