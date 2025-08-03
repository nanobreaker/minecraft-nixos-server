# Minecraft NixBlade Server

A minecraft server managed by nixos targeting raspberry compute module 5 hardware.

> [!info]
> Based on https://github.com/nvmd/nixos-raspberrypi

# Preview

![preview_0](screenshot-0.png)

# Overview

This repo represents nix based configuration of minecraft server specialised
to run on compute blade cluster.

It deploys minecraft server based on popular modded version of the game named
better minecraft 4. LunaPixelStudios provide server ready package in a form of zip file
which can be easily installed into the system.

Additionally optimized pefromance by using graalvm with custom configuration
of garbage collector and other flags to minimize memory usage and increase performance.

> [!info]
> Learn about [compute blade](https://computeblade.com/)

# Prerequisities

## Raspberry Compute Module 5
