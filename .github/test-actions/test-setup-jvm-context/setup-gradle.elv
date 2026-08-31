use os

echo 🎭 Setting up a legacy JVM context with ☕Java 1.8 and 🐘Gradle...

get-env temp-project-dir |
  cd (all)

os:remove-all pom.xml

touch build.gradle
