use ./base
use ./descriptors/gradle

fn load-project { |descriptor-name|
  base:load-project [
    &descriptor-namespace=$gradle:

    &descriptor-name=$descriptor-name

    &technology=Gradle

    &build-tool=gradle

    &emoji=🐘
  ]
}
