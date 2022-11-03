#!/usr/bin/env
# Will have to source this in shell rc file

osPath=$HOME/myexpos

xfsi() {
    local currentDir=$PWD
    cd $osPath/xfs-interface
    ./xfs-interface
    cd $currentDir
}

xsm() {
    local currentDir=$PWD
    cd $osPath/xsm
    ./xsm $@
    cd $currentDir
}

spl() {
    local currentDir=$PWD
    for filename in "$@"
    do
        local filePath=$(readlink -f $filename)
        cd $osPath/spl
        op=$(./spl $filePath 2>&1)
        if [[ ! -z $op ]]
        then
            echo "Error compiling $filename"
            echo "$op" | xargs
            echo
        fi
        cd $currentDir
    done
}

expl() {
    local currentDir=$PWD
    for filename in "$@"
    do
        local filePath=$(readlink -f $filename)
        cd $osPath/expl
        op=$(./expl $filePath 2>&1)
        if [[ ! -z $op ]]
        then
            echo "Error compiling $filename"
            echo "$op" | xargs
            echo
        fi
        cd $currentDir
    done
}

load() {
    local currentDir=$PWD
    if [[ -z $1 ]]
    then
        cd $osPath/spl/spl_progs
        spl *.spl
        cd $osPath/expl/expl_progs
        expl *.expl
        cd $osPath/xfs-interface
        ./xfs-interface run ../tools/load
    elif [[ $1 == "-e" ]]
    then
        cd $osPath/expl/expl_progs
        expl *.expl
        : > /tmp/loadCommand
        for filename in *.expl
        do
            echo "rm ${filename%.expl}.xsm" >> /tmp/loadCommand
            echo "load --exec ${$(readlink -f $filename)%.expl}.xsm" >> /tmp/loadCommand
        done
        cd $osPath/xfs-interface
        ./xfs-interface run /tmp/loadCommand > /dev/null 2>&1
    else
        : > /tmp/loadCommand
        for filename in "$@"
        do
            local filePath=$(readlink -f $filename)
            expl $filePath
            echo "rm ${filename%.expl}.xsm" >> /tmp/loadCommand
            echo "load --exec ${filePath%.expl}.xsm" >> /tmp/loadCommand
        done
        cd $osPath/xfs-interface
        ./xfs-interface run /tmp/loadCommand > /dev/null 2>&1
    fi
    cd $currentDir
}