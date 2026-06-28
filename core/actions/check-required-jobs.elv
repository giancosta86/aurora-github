use github.com/giancosta86/ethereal/v1/lang
use ../console
use ./input

var result-descriptions = [
  &success='✅ (OK)'
  &failure='❌ (FAILURE)'
  &skipped='😴 (SKIPPED)'
]

var unknown-result-description = '❓ (UNKNOWN)'

fn main {
  var needs-as-json = (input:string needs-as-json)

  console:section &emoji=🐟 'needs-as-json' {
    echo $needs-as-json
  }

  var required-jobs = (echo $needs-as-json | from-json)

  var failure = $false

  console:section &emoji=🤹 'JOB SUMMARY' {
    keys $required-jobs |
      order |
      each { |job-id|
        var raw-job = $required-jobs[$job-id]

        var job-result = $raw-job[result]

        if (not-eq $job-result success) {
          set failure = $true
        }

        var result-description = (
          lang:get-value $result-descriptions $job-result &default=$unknown-result-description
        )

        console:echo '* '$job-id': '$result-description
      }
  }

  if $failure {
    fail 'All the required jobs must be successful!'
  }

  console:echo ✅ All the required jobs are OK!
}
