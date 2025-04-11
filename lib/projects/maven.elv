use ./base
use ./xml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=Maven

    &emoji=🪶

    &descriptor-name=pom.xml

    &version-reader=$xml:read-version~

    &build-tool=mvn
  ]
}
