use os
use path
use ./console
use ./seq
use ./env

fn -set-strategy { |strategy|
  console:inspect &emoji=💡 'Current GitHub Pages strategy' $strategy
  env:write strategy $strategy
}

fn -enforce-exit-strategy {
  -set-strategy exit
}

fn detect-strategy-from-sources { |source-directory optional|
  console:inspect &emoji=📁 'Source directory' $source-directory

  console:inspect &emoji=💭 'Optional' $optional

  if (seq:is-empty $source-directory) {
    if $optional {
      echo 💬Missing action input: "'"source-directory"'" - cannot publish to GitHub Pages
      -enforce-exit-strategy
      return
    } else {
      fail 'Missing action input: ''source-directory''!'
    }
  }

  if (not (os:is-dir $source-directory)) {
    if $optional {
      echo 💬Missing website directory "'"$source-directory"'" - cannot publish to GitHub Pages
      -enforce-exit-strategy
      return
    } else {
      fail "Missing website directory: '"$source-directory"'!"
    }
  }

  echo 🌐📁Website source directory "'"$source-directory"'" found!

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

  echo 📦Now building the website via NodeJS...
  pnpm build
  echo ✅Website ready!

  set-artifact-directory $source-directory dist
}

fn build-via-maven { |source-directory|
  tmp pwd = $source-directory

  echo 🪶Now building the website via Maven...
  mvn -q site
  echo ✅Website ready!

  set-artifact-directory $source-directory target site
}

fn check-artifact-directory { |artifact-directory optional|
  console:inspect &emoji=📁 'Website artifact directory' $artifact-directory

  if (os:is-dir $artifact-directory) {
    echo ✅The artifact directory for the 🌐website exists!
  } else {
    if $optional {
      echo 💬Missing website artifact directory - cannot publish to GitHub Pages
      -enforce-exit-strategy
    } else {
      fail 'Missing website artifact directory!'
    }
  }
}

fn skip-publication-on-dry-run { |dry-run|
  if $dry-run {
    echo 💭Skipping publication, as requested by dry-run.
    -enforce-exit-strategy
  }
}
