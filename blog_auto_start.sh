#!/bin/bash
export JAVA_HOME=/usr/local/plumemo/jdk1.8.0_144
export PATH=$JAVA_HOME/bin:$PATH
nginx
sh /usr/local/plumemo/deploy.sh
ping 127.0.0.1