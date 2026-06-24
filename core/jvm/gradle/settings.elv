use str
use ./descriptor

fn prepare-for-publication {
  echo 🐘 Preparing Gradle settings for publication...

  var descriptor-name = (descriptor:get-name)

  var descriptor-content = (slurp < $descriptor-name)

  console:section &emoji=🐘 'Checking the optional use of environment variables in the descriptor' {
    for env-var [JVM_AUTH_USER JVM_AUTH_TOKEN] {
      if (str:contains $descriptor-content $env-var) {
        console:inspect &emoji=✅ 'Referenced' $env-var
      } else {
        console:inspect &emoji=💭 'Not mentioned' $env-var
      }
    }
  }

  echo ✅ Gradle settings now ready!
}