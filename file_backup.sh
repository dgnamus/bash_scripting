#!/bin/bash
perform_backup() {
    mkdir backup
    cd backup
    cp -r ${1} .
    tar -czvf backup.tar.gz *
    echo "Backup complete!"
}

perform_backup ${1}

exit 0