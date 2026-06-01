use str
use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/edit
use github.com/giancosta86/aurora-elvish/map
use ../project

fn -inject { |project|
  console:echo 🧬 Injecting branch version into project: ($project[to-string])

  var branch-version = (detect)[version]

  edit:file $project[descriptor-path] { |text|
    str:replace '0.0.0' $branch-version $text
  }

  console:echo ✅ Version injected!

  $project[print-descriptor]
}

fn -check { |project|
  console:echo 🔎 Checking branch version for project: ($project[to-string])

  $project[print-descriptor]

  var branch-version = (detect)[version]
  console:inspect &emoji=🌲 'Branch version' $branch-version

  var project-version = ($project[read-version])

  if $project-version {
    console:inspect &emoji=🏷 'Project version' $project-version

    if (==s $project-version $branch-version) {
      console:echo ✅ The project version matches the branch version!
    } else {
      fail 'The project version and the branch version do not match!'
    }
  } else {
    console:echo 💭 The project version cannot be detected...
    console:echo 🔎 Ensuring the branch version is mentioned in the descriptor...

    var descriptor-content = (slurp < $project[descriptor-path])

    if (str:contains $descriptor-content $branch-version) {
      console:echo ✅ Branch version found in the descriptor!
    } else {
      fail 'The branch version cannot be found in the artifact descriptor!'
    }
  }
}

var -strategies = [
  &inject=$-inject~

  &check=$-check~

  &skip={ |_|
    console:echo 💭 Skipping branch version enforcement, as requested...
  }
]

fn enforce { |&descriptor-name=$nil mode|
  var strategy = (map:get-value $-strategies $mode &default={
    fail "Invalid mode: '"$mode"'"
  })

  var project = (project:detect &descriptor-name=$descriptor-name)

  $strategy $project
}
