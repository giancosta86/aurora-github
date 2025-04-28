use github.com/giancosta86/aurora-elvish/console
use github.com/giancosta86/aurora-elvish/map

var -result-descriptions = [
  &success='✅ (OK)'
  &failure='❌ (FAILURE)'
  &skipped='😴 (SKIPPED)'
]

var -unknown-result-description = '❓ (UNKNOWN)'

fn check { |needs-as-json|
  var failure = $false

  var required-jobs = (echo $needs-as-json | from-json)

  console:section &emoji=🤹 'JOB SUMMARY' {
    keys $required-jobs |
      order |
      each { |job-id|
        var raw-job = $required-jobs[$job-id]

        var job-result = $raw-job[result]

        if (!=s $job-result success) {
          set failure = $true
        }

        var result-description = (
          map:get-value $-result-descriptions $job-result &default=$-unknown-result-description
        )

        console:echo '* '$job-id': '$result-description
      }
  }

  if $failure {
    fail 'All the required jobs must be successful!'
  }

  console:echo ✅ All the required jobs are OK!
}
