use github.com/giancosta86/ethereal/v1/lang

var modules-by-build-tool = [
  &mvn='./maven'

  &gradle='./gradle'
]

fn get-module { |@arguments|
  var build-tool = (lang:get-single-input $arguments)

  use-mod $modules-by-build-tool[$build-tool]
}