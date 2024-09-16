#!/bin/bash

WATCH_DIR="/usr/app/src"
DIST_DIR="/usr/app/dist"

mkdir -p $DIST_DIR

build_and_run() {
    echo -e "Changes detected. Recompiling and running...\n"
    echo "------------------------------------|"

    rm -rf $DIST_DIR/*.class

    javac -d $DIST_DIR $WATCH_DIR/*.java
    if [ $? -ne 0 ]; then
        echo "Compilation failed."
        return
    fi

    # Run the Java application
    java -cp $DIST_DIR MainClass
    if [ $? -ne 0 ]; then
        echo "Execution failed."
    fi

    echo -e "------------------------------------|\n"
}

cleanup() {
    echo "Exiting terminal..."
    exit 0
}
trap cleanup SIGINT

build_and_run

(
    while true; do
        fswatch -1 $WATCH_DIR && build_and_run
    done
) &

wait