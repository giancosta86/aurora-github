use os
use ./shared

echo 🎭 Setting up a legacy JVM context with ☕Java 1.8 and 🪶Maven...

shared:within-temp-project {
  fs:touch pom.xml
}
