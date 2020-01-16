#!/bin/bash
podman stop $(podman ps -aq)
podman rm $(podman ps -aq)
