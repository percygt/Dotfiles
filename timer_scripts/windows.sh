#!/bin/bash

virsh start win10
sleep 5
remote-viewer spice://127.0.0.1:5900

