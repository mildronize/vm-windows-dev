# vm-windows-dev
A Productive Development with Virtual Machine on Windows

> This project is an unstable project. No have release version

This project is inspired from [docker-osx-dev](https://github.com/brikis98/docker-osx-dev)

## Prerequisite
- [Winscp](https://winscp.net/)
- [PuTTY](http://www.putty.org/)

## Installation
1. Clone this project.
2. Set the environment variable for this project. Ex: `C:\vm-windows-dev\bin`
3. Use `PuTTYgen` for creating a private key
4. Setup the variables in the script. Ex: `C:\vm-windows-dev\bin\vm-windows-dev.bat`

## Usage
```
C:\> vm-windows-dev
```

## CLI
```
# Quick start ( start vm + sync )
C:\> vm-windows-dev

# Start and stop with default VM name
C:\> vm-windows-dev start
C:\> vm-windows-dev stop

C:\> vm-windows-dev attach
C:\> vm-windows-dev sync

C:\> vm-windows-dev help

# List virtual machines
C:\> vm-windows-dev ls
C:\> vm-windows-dev list
```

## Todo
- Move to bash shell script
