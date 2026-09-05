# check-required-jobs

Verifies that all the jobs in the `needs:` directive of the current job have completed successfully.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/check-required-jobs@v13
    with:
      needs-as-json: ${{ toJSON(needs) }}
```

## 💡 How it works

1. Extract the list of required jobs from the `needs:` directive of the **job** containing this action.

1. Wait for all the required jobs to provide an outcome (**success**, **failure**, **skipped**).

1. Display, within a summary, the **outcome** of each required job.

1. Ensure that every required job:
   1. has actually run - **skipped** jobs trigger an error just like **failed** ones.

   1. has completed successfully.

## 💬 Remarks

This action is especially effective in a **job** that:

- is declared **at the end** of its workflow.

- references **all** the previous jobs via the `needs:` directive.

- is flagged (the containing job, _not_ the action) with `if: always()`, ensuring it will always run - even if the required jobs have a **failed** or **skipped** outcome.

### Recommended strategy

You might want to flag **all the other jobs** in the workflow with the `if: true` flag, which has no effect; however should you need to run only a selected number of jobs (for example, while developing a feature), you can:

1. Replace `if: true` with `if: false` to skip inessential jobs.

1. Replace `if: true` with `if: always()` for the jobs you want to run - so that _they will run even though their required jobs have been skipped_.

1. Anyway, this action acts as a barrier preventing the CI/CD branch checks to pass - because **skipped jobs result in an overall failure**.

## ☑️ Requirements

The job containing this action should have a `need:` list mentioning previous jobs in the workflow.

## 📥 Inputs

|      Name       | Type |            Description             | Default value |
| :-------------: | :--: | :--------------------------------: | :-----------: |
| `needs-as-json` |      | Always pass `${{ toJSON(needs) }}` |               |

## 🌐 Further references

- [aurora-github](../../README.md)
