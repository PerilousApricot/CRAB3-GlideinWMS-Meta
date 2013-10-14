#!/bin/bash

# Move the developer's credentials from ~ on the host to ~ in the VM
OPTIONS=$(vagrant ssh-config | awk -v ORS=' ' '{print "-o " $1 "=" $2}')
if [[ -d ~/.globus ]]; then
    echo "Moving ~/.globus into VM"
    scp -r ${OPTIONS} ~/.globus localhost:~
else
    echo "Not moving ~/.globus (not found)"
fi

ssh ${OPTIONS} localhost mkdir -p /home/vagrant/.ssh
for KEY in ~/.ssh/id_*; do
    if [[ -f $KEY ]]; then
        echo "Moving $KEY into VM"
        scp ${OPTIONS} $KEY localhost:/home/vagrant/.ssh/$(basename $KEY)
    fi
done
