use ./base
use ./xml

fn load-project { |directory|
  base:load-project [
    &directory=$directory

    &technology=Maven

    &icon=🪶

    &descriptor-name=pom.xml

    &version-retriever=$xml:read-version~

    &build-tool=mvn
  ]
}
