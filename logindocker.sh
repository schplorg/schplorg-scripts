#!/bin/bash
podman start $1
podman attach $1
