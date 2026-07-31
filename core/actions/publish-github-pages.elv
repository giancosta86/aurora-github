use os
use path
use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/gauntlet/v1/env
use ../jvm/maven

fn detect-strategy {
  var env-variables = (
    if (os:is-regular package.json) {
      put [
        &strategy=nodejs-site
        &source-directory=(path:join $pwd dist)
      ]
    } elif (os:is-regular pom.xml) {
      put [
        &strategy=maven-site
        &source-directory=(path:join $pwd target site)
      ]
    } else {
      put [
        &strategy=static-site
        &source-directory=$pwd
      ]
    }
  )

  console:inspect &emoji=🌐 'Website environment variables for GitHub Pages' $env-variables

  env:map $env-variables
}

fn build-via-maven {
  echo 🪶 Now building the website via Maven...

  maven:run site

  echo ✅ Website built!
}