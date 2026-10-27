# Smallhands

A simple mod that makes item hands smaller.

This project is currently being reworked.

Official release on Modrinth:  
https://modrinth.com/mod/small-items-mod

Everything in this GitHub repository is a work in progress.

Info:  
This branch supports Minecraft 1.20–1.21.11. Minecraft 1.20–1.20.4 needs Java 17; later versions need Java 21.
Newer Minecraft versions have their own branches.

## Building

Requires Java 25 to run the build. The default target uses Java 21.

```sh
./gradlew build
```

The mod jar is written to `build/libs/smallhands-<version>.jar`. Run `./gradlew runClient` to start a test client with Mod Menu installed. Use `-Pminecraft_target=1.20.1` with either command to select another version.

Run `./build-all.ps1` in PowerShell to build every version supported by this branch into `build/releases`. In IntelliJ, use JDK 25 for Gradle; the Java 17 and 21 toolchains are selected automatically.
