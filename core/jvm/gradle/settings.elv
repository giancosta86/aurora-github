use str
use ../../std-err

fn prepare-for-publication {
  echo 🐘 Preparing Gradle settings for publication...

  var descriptor = (get-env jvm-descriptor)

  var descriptor-content = (slurp < $descriptor)

  std-err:section &emoji=🐘 'Checking the optional use of environment variables in the descriptor' {
    all [
      JVM_AUTH_USER
      JVM_AUTH_TOKEN
    ] | each { |env-var|
      if (str:contains $descriptor-content $env-var) {
        std-err:inspect &emoji=✅ 'Referenced' $env-var
      } else {
        std-err:inspect &emoji=💭 'Not mentioned' $env-var
      }
    }
  }

  echo ✅ Gradle settings now ready!
}