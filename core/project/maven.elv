use ./base
use ./descriptors/xml

fn load-project {
  base:load-project [
    &descriptor-namespace=$xml:

    &descriptor-name=pom.xml

    &technology=Maven

    &build-tool=mvn

    &emoji=🪶
  ]
}
