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
    ./xsm $1
    cd $currentDir
}

spl() {
    local filePath=$(readlink -f $1)
    local currentDir=$PWD
    cd $osPath/spl
    ./spl $filePath
    cd $currentDir
}

expl() {
    local filePath=$(readlink -f $1)
    local currentDir=$PWD
    cd $osPath/expl
    ./expl $filePath
    cd $currentDir
}

load() {
    local currentDir=$PWD
    cd $osPath/spl/spl_progs
    for i in *.spl
    do
        spl $i
    done
    cd $osPath/expl/expl_progs
    for i in *.expl
    do
        expl $i
    done
    cd $osPath/xfs-interface
    ./xfs-interface run ../tools/load
    cd $currentDir
}
