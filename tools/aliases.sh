#!/usr/bin/env
# Will have to source this in shell rc file

osPath=$HOME/myexpos

xfsi() {
    currentDir=$(pwd)
    cd $osPath/xfs-interface
    ./xfs-interface
    cd $currentDir
}

xsm() {
    currentDir=$(pwd)
    cd $osPath/xsm
    ./xsm $1
    cd $currentDir
}

spl() {
    filePath=$(readlink -f $1)
    currentDir=$(pwd)
    cd $osPath/spl
    ./spl $filePath
    cd $currentDir
}

expl() {
    filePath=$(readlink -f $1)
    currentDir=$(pwd)
    cd $osPath/expl
    ./expl $filePath
    cd $currentDir
}

load() {
    currentDir=$(pwd)
    cd $osPath/xfs-interface
    ./xfs-interface run ../tools/load
    cd $currentDir
}
