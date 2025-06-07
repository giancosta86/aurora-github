# tag-and-release

Merges a pull request, creates a **Git** tag and publishes a **GitHub** release, from a Git branch named according to [semantic versioning](https://semver.org/).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/tag-and-release@v11
```

It is essential to remember that this action must be called:

- from a workflow **not triggered by a pull request event** - in particular, it should be one _manually triggered_:

  ```yml
  on:
  workflow_dispatch:
  ```

- from a branch _associated with a pull request_ - which can be selected when starting the workflow

The only exception is when `dry-run` is set to **true**.

More generally, this action should be _the very last step_ in a manually-triggered workflow performing _artifact publication_ - so that the pull request gets closed and the related resources released once all the other steps are successful.

## 💡 How it works

1. If the pull request associated with the current branch is open (as it should), merge it - using the selected `git-strategy` for merging/rebasing the code and deleting the branch

1. Create a new tag - for example, `vX.Y.Z` - containing the semantic version inferred from the branch name.

1. Generate the release notes - based on the Git commit list

1. If `notes-file-processor` is not an empty string, it will be interpreted as the `script-file` input of [run-shell-script](../run-shell-script/README.md)

1. Create or draft a GitHub release.

1. Optionally, _create or move_ the tag of the major version related to the current version - for example, `vX`.

## ☑️ Requirements

- Unless the `dry-run` input is set to **true**, this action can only be called:

  - **within a workflow not triggered by a pull request**; in particular, it should be invoked from within a **manually-triggered** workflow

  - from a branch **associated with a pull request**; as a corollary, the action _cannot be run from the default branch_.

    Strictly speaking, the pull request **does not have to be open** - in certain situations, you might want to close the pull request via the web interface (for example, to configure the Git merge message) and later run `tag-and-release`, as long as the underlying branch is still available; however, that would defeat the very purpose of the action - which is _closing the pull request at the end of a successful publication pipeline_.

- The following [permission](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work

  - `contents`: **write**

  It is active by default - but it must be explicitly enabled when other permissions are declared

- Within the **Settings** tab of the project web interface on GitHub, the following **Workflow permissions** must be selected:

  - **Read and write permissions**

- The branch name can safely start with `v` - and it actually should - because the tags are created after the deletion of the branch.

- The requirements discussed for [detect-branch-version](../detect-branch-version/README.md) also apply.

## 📥 Inputs

|          Name          |            Type             |                        Description                        | Default value |
| :--------------------: | :-------------------------: | :-------------------------------------------------------: | :-----------: |
|     `git-strategy`     |  `merge`,`rebase`,`squash`  |    How to apply the pull request to the Git repository    |  **squash**   |
|    `draft-release`     | `true`, `false`, `on-major` |           Draft the release - do not publish it           | **on-major**  |
| `notes-file-processor` |         **string**          |     Shell script editing the generated release notes      |               |
|    `set-major-tag`     |         **boolean**         | Create/move the `vX` tag to this commit (X=major version) |   **false**   |
|       `dry-run`        |         **boolean**         |        Run the action without performing commands         |   **false**   |

- The `draft-release` input, when set to **on-major**, will become **true** only if the semantic version detected from the current branch has the form `X.0.0` - otherwise, it will fallback to **false**.

## 📤 Outputs

|     Name      |    Type    |               Description                |  Example   |
| :-----------: | :--------: | :--------------------------------------: | :--------: |
| `release-tag` | **string** | The Git tag associated with the release  | **v7.4.9** |
|  `major-tag`  | **string** | The Git tag of the major version, if set |   **v7**   |

## 🌐 Further references

- [run-shell-script](../run-shell-script/README.md)

- [semver](https://semver.org/)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
