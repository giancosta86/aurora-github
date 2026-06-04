use str
use github.com/giancosta86/ethereal/v1/edit
use github.com/giancosta86/ethereal/v1/lang
use ../ci-cd/env
use ../project
use ../std-err
use ./detection

fn -inject { |project|
  std-err:inspect &emoji=🧬 'Injecting branch version into project' ($project[to-string])

  var branch-version = (detection:detect)[version]

  edit:file $project[descriptor-path] { |text|
    str:replace '0.0.0' $branch-version $text
  }

  std-err:echo ✅ Version injected!

  $project[print-descriptor]
}

fn -check { |project|
  std-err:inspect 'Checking branch version for project' ($project[to-string])

  $project[print-descriptor]

  var branch-version = (detection:detect)[version]
  std-err:inspect &emoji=🌲 'Branch version' $branch-version

  var project-version = ($project[read-version])

  if $project-version {
    std-err:inspect &emoji=🏷 'Project version' $project-version

    if (eq $project-version $branch-version) {
      std-err:echo ✅ The project version matches the branch version!
    } else {
      fail 'The project version and the branch version do not match!'
    }
  } else {
    std-err:capture {
      echo 💭 The project version cannot be detected...
      echo 🔎 Ensuring the branch version is mentioned in the descriptor...
    }

    var descriptor-content = (slurp < $project[descriptor-path])

    if (str:contains $descriptor-content $branch-version) {
      std-err:echo ✅ Branch version found in the descriptor!
    } else {
      fail 'The branch version cannot be found in the artifact descriptor!'
    }
  }
}

var -strategies = [
  &inject=$-inject~

  &check=$-check~

  &skip={ |_|
    std-err:echo 💭 Skipping branch version enforcement, as requested...
  }
]

fn enforce { |&descriptor-name=$nil mode|
  var strategy = (lang:get-value $-strategies $mode &default={
    fail "Invalid mode: '"$mode"'"
  })

  var project = (project:detect &descriptor-name=$descriptor-name)

  $strategy $project
}
