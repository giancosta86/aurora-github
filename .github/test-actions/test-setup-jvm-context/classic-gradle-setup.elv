use os
use github.com/giancosta86/ethereal/v1/fs
use ./shared

echo 🎭 Setting up a legacy JVM context with ☕Java 1.8 and classic 🐘Gradle...

shared:within-temp-project {
  fs:touch build.gradle
}
