use str
use ../../console

fn prepare-for-publication {
  echo 🐘 Preparing Gradle settings for publication...

  var descriptor = (get-env jvm-descriptor)

  var descriptor-content = (slurp < $descriptor)

  console:section &emoji=🐘 'Checking the optional use of environment variables in the descriptor' {
    all [
      JVM_AUTH_USER
      JVM_AUTH_TOKEN
    ] | each { |env-var|
      if (str:contains $descriptor-content $env-var) {
        console:inspect &emoji=✅ 'Referenced' $env-var
      } else {
        console:inspect &emoji=💭 'Not mentioned' $env-var
      }
    }
  }

  echo ✅ Gradle settings now ready!
}