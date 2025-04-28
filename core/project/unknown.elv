use ./base
use ./descriptors/plain-text

fn load-project { |descriptor-name|
  base:load-project [
    &descriptor-namespace=$plain-text:

    &descriptor-name=$descriptor-name

    &technology=Unknown

    &build-tool=$nil

    &emoji=🎁
  ]
}
