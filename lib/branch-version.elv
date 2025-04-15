use re
use str
use path
use ./core
use ./console
use ./project

fn detect {
  var head-ref = $E:GITHUB_HEAD_REF
  var ref = $E:GITHUB_REF

  var retrieved-branch = (
    core:ternary (core:not-empty $head-ref) $head-ref $ref
  )

  if (core:empty $retrieved-branch) {
    fail "Cannot retrieve the branch!"
  }

  console:inspect &emoji=🌳 "Retrieved Git branch name" $retrieved-branch

  var branch = (path:base $retrieved-branch)
  console:inspect &emoji=🌲 "Current Git branch" $branch

  var version = (str:trim-prefix $branch v)
  console:inspect &emoji=🦋 "Detected version" $version

  var escaped-version = (re:quote $version)
  console:inspect &emoji=🧵 "Escaped version" $escaped-version

  var major = (
    put $version |
      str:split . (all) |
      take 1 |
      str:split - (all) |
      take 1 |
      str:split + (all) |
      take 1
  )
  console:inspect &emoji=🪩 "Major version" $major
  put [
    &branch=$branch
    &version=$version
    &escaped-version=$escaped-version
    &major=$major
  ]
}

fn -inject { |project|
  var branch-version = (detect)[version]

  core:edit-file $project[descriptor-path] { |text|
    str:replace '0.0.0' $branch-version $text
  }

  echo ✅Version injected!

  $project[print-descriptor]
}

fn -check { |project|
  $project[print-descriptor]

  var branch-version = (detect)[version]
  console:inspect &emoji=🌲 'Branch version' $branch-version

  var project-version = ($project[read-version])

  if (is $project-version $nil) {
    console:print "🏷The project version cannot be detected"
    echo 🔎Ensuring the branch version exists in the project...

    var descriptor-content = (slurp < $project[descriptor-path])

    if (str:contains $descriptor-content $branch-version) {
      echo ✅Branch version found in the descriptor!
    } else {
      fail 'The branch version cannot be found in the artifact descriptor!'
    }
  } else {
    console:inspect &emoji=🏷 'Project version' $project-version

    if (==s $project-version $branch-version) {
      echo ✅The project version matches the branch version!
    } else {
      fail 'The project version and the branch version do not match!'
    }
  }
}

fn enforce { |project-directory mode &descriptor-name=$nil|
  var strategies = [
    &inject={
      var project = (project:detect &descriptor-name=$descriptor-name $project-directory)
      echo 🧬Injecting branch version into project: ($project[to-string])
      -inject $project
    }

    &check={
      var project = (project:detect &descriptor-name=$descriptor-name $project-directory)
      echo 🔎Checking branch version for project: ($project[to-string])
      -check $project
    }

    &skip={
      echo 💭Skipping branch version enforcement, as requested...
    }
  ]

  if (not (has-key $strategies $mode)) {
    fail "Invalid mode: '"$mode"'"
  }

  $strategies[$mode]
}
