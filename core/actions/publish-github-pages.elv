use os
use ../ci-cd/env
use ../jvm/maven
use ../std-err
use ./input

fn detect-strategy {
  var env-variables = (
    if (os:is-regular package.json) {
      put [
        &strategy=nodejs-site
        &source-dir=dist
      ]
    } elif (os:is-regular pom.xml) {
      put [
        &strategy=maven-site
        &source-dir=(path:join target site)
      ]
    } else {
      put [
        &strategy=static-site
        &source-dir=.
      ]
    }
  )

  std-err:inspect &emoji=🌐 'Website environment variables for GitHub Pages' $env-variables

  env:map $env-variables
}

fn build-via-maven {
  echo 🪶 Now building the website via Maven...

  maven:run site

  echo ✅ Website built!
}