use github.com/giancosta86/ethereal/v1/console
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/gauntlet/v1/input

var result-descriptions = [
  &success='✅ (OK)'
  &failure='❌ (FAILURE)'
  &skipped='😴 (SKIPPED)'
]

var unknown-result-description = '❓ (UNKNOWN)'

fn main {
  var needs-as-json = (input:string needs-as-json)

  var required-jobs = (
    echo $needs-as-json |
      from-json
  )

  var failure = $false

  console:section &emoji=🤹 'JOB SUMMARY' {
    keys $required-jobs |
      order |
      each { |job-id|
        var job = $required-jobs[$job-id]

        var job-result = $job[result]

        if (not-eq $job-result success) {
          set failure = $true
        }

        var result-description = (
          lang:get-value $result-descriptions $job-result &default=$unknown-result-description
        )

        echo '* '$job-id': '$result-description
      }
  }

  if $failure {
    fail 'All the required jobs must be successful!'
  }

  echo ✅ All the required jobs are OK!
}
