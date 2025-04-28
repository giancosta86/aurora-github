use os
use path
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/seq
use ./ci-cd/env

fn -set-strategy { |strategy|
  console:inspect &emoji=💡 'Current website publication strategy' $strategy
  env:write strategy $strategy
}

fn -enforce-exit-strategy {
  -set-strategy exit
}

fn detect-strategy-from-sources { |source-directory|
  if (not $source-directory) {
    -enforce-exit-strategy
    return
  }

  console:inspect &emoji=🌐📁 'Website source directory' $source-directory

  tmp pwd = $source-directory

  if (os:is-regular package.json) {
    -set-strategy nodejs
  } elif (os:is-regular pom.xml) {
    -set-strategy maven
  } else {
    -set-strategy static-files
  }
}

fn set-artifact-directory { |@path-components|
  env:write artifactDirectory (path:join $@path-components)
}

fn build-via-nodejs { |source-directory|
  tmp pwd = $source-directory

  console:echo 📦 Now building the website via NodeJS...
  pnpm build
  console:echo ✅ Website built!

  set-artifact-directory $source-directory dist
}

fn build-via-maven { |source-directory|
  use ./jvm/context
  use ./jvm/maven

  tmp pwd = $source-directory

  context:setup

  console:echo 🪶 Now building the website via Maven...
  maven:run site
  console:echo ✅ Website built!

  set-artifact-directory $source-directory target site
}

fn check-artifact-directory { |artifact-directory optional|
  console:inspect &emoji=📁 'Website artifact directory' $artifact-directory

  if (os:is-dir $artifact-directory) {
    console:echo ✅ The artifact directory for the 🌐 website exists!
  } else {
    if $optional {
      console:echo 💬 Missing website artifact directory - cannot publish website
      -enforce-exit-strategy
    } else {
      fail 'Missing website artifact directory!'
    }
  }
}

fn skip-publication-on-dry-run { |dry-run|
  if $dry-run {
    console:echo 💭 Skipping publication, as requested by dry-run.
    -enforce-exit-strategy
  }
}
