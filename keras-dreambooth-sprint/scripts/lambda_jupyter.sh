#!/usr/bin/env bash

# steal lambda's autostarting jupyterlab
# this is useful for getting new ~/.bashrc content
jupyter lab stop 7000
jupyter lab --port 7000
