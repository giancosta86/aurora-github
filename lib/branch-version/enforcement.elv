use re
use str
use path
use ../console
use ../map
use ../project
use ../files
use ./detection


fn -inject { |project|
  var branch-version = (detection:detect)[version]

  files:edit $project[descriptor-path] { |text|
    str:replace '0.0.0' $branch-version $text
  }

  echo ✅Version injected!

  $project[print-descriptor]
}

fn -check { |project|
  $project[print-descriptor]

  var branch-version = (detection:detect)[version]
  console:inspect &emoji=🌲 'Branch version' $branch-version

  var project-version = ($project[read-version])

  if (is $project-version $nil) {
    echo 🏷The project version cannot be detected
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

fn enforce { |&descriptor-name=$nil project-directory mode|
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

  (map:get-value $strategies $mode &default={
    fail "Invalid mode: '"$mode"'"
  })
}
