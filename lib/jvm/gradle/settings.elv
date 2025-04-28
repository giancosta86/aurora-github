use str
use ../../console

fn check { |descriptor-name|
  var descriptor-content = (slurp < $descriptor-name)

  console:section &emoji=🐘 'Checking the optional use of environment variables in the descriptor' {
    for env-var [JVM_AUTH_USER JVM_AUTH_TOKEN] {
      if (str:contains $descriptor-content $env-var) {
        console:inspect &emoji=✅ 'Environment variable referenced by the project descriptor' $env-var
      } else {
        console:inspect &emoji=💭 'Environment variable not mentioned in the project descriptor' $env-var
      }
    }
  }
}