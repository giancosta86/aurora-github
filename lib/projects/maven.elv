use ./base
use ./xml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &descriptor-name=pom.xml

    &technology=Maven

    &build-tool=mvn

    &emoji=🪶

    &version-reader=$xml:read-version~
  ]
}
