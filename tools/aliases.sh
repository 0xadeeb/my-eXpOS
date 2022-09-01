#!/usr/bin/zsh
# Will have to source this in ~/.zshrc

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
