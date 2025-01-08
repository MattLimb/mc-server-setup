# Minecraft Server Setup

This repo is an open set of scripts which setup Fabric Minecraft as systemd Service on Ubuntu 24.04 Server.

> [!CAUTION]
> This is a personal project. Please do read, understand and modify these scripts as appliciable.

This is a fork of [jtait's minecraft systemd repo](https://github.com/jtait/minecraft_systemd) - but I intend to maintain this as a seperate project.

## Install

1. Install Just and Git

```sh
$ sudo apt install -y just git
```

2. Git Clone

```sh
$ git clone https://github.com/MattLimb/mc-server-setup.git
```

## Useful Commands

In all these commands `<name>` will be used to refer to the name of a Minecraft Server. If you are running multiple severs, these names MUST be unique.


| Command                                   | Description                                                                                          |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `just install`                            | Install Java, setup folder structre, setup `minecraft` user account and setup systemd.               |
| `just new`                                | DEFAULT way to make a new minecraft server. This creates a minecraft server named `server`.          |
| `just name=<name> new`                    | Create a custom named minecraft server.                                                              |
| `just name=<name> remove`                 | Stop and remove the named Minecraft server.                                                          |
| `systemctl status minecraft@<name>`       | Get the current status of the `<name>`ed minecraft server.                                           |
| `journalctl -efu minecraft@<name>`        | Get the logs for the `<name>`ed minecraft server. This auto-tails the logs, so press CTRL+C to exit. |
| `systemctl stop minecraft@<name>`         | Stop the `<name>`ed minecraft server.                                                                |
| `systemctl start minecraft@<name>`        | Start the `<name>`ed minecraft server.                                                               |
| `systemctl disable minecraft@<name>`      | Stop the `<name>`ed minecraft server from starting at boot time.                                     |
| `systemctl enable minecraft@<name>`       | Start the `<name>`ed minecraft server from starting at boot time.                                    |
| `systemctl enable --now minecraft@<name>` | Start the `<name>`ed minecraft server from starting at boot time, and start the service now.         |