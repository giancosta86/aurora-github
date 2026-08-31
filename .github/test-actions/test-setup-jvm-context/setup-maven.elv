use os

echo 🎭 Setting up a legacy JVM context with ☕Java 1.8 and 🪶Maven...

get-env temp-project-dir |
  cd (all)

os:remove-all build.gradle

touch pom.xml
