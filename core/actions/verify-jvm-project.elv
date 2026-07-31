use github.com/giancosta86/gauntlet/v1/input

var verifier-modules-by-build-tool = [
  &mvn='../jvm/maven'

  &gradle='../jvm/gradle'
]

fn main {
  var quiet-tool = (input:bool quiet-tool)

  var jvm-build-tool = (get-env jvm-build-tool)

  var verifier-module: = (
    use-mod $verifier-modules-by-build-tool[$jvm-build-tool]
  )

  verifier-module:verify-project &quiet=$quiet-tool
}