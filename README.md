# Smallhands

A simple mod that makes item hands smaller.

This project is currently being reworked.

Official release on Modrinth:  
https://modrinth.com/mod/small-items-mod

Everything in this GitHub repository is a work in progress.

Info:  
This branch builds one jar for Minecraft 1.20.2–1.21.11. Java 17 or later is required; Minecraft 1.20.5 and later need Java 21.

## Building

Requires Java 25 to run the build. The mod is compiled for Java 17.

```sh
./gradlew build
```

The mod jar is written to `build/libs/smallhands-<version>.jar`. Run `./gradlew runClient` to start a test client with Mod Menu installed. In IntelliJ, use JDK 25 for Gradle and the Java 17 toolchain for the mod.
