# tag-and-release

Creates a **Git** tag and a **GitHub** release, from a Git branch named according to [semver](https://semver.org/) - that is deleted during the process.

## 🃏Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/tag-and-release@v9
```

## ☑️Requirements

- This action can only be used in a workflow running while **merging a pull request** - unless its `dry-run` input is set to **true**; as a corollary, it cannot be run from the _default_ branch of the repository

- The following [permission](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work - especially during the _branch deletion_ process:

  - `contents`: **write**

  It is already active by default - but declaring other permissions will implicitly disable it.

- GitHub Actions must have **read/write** permissions on the repository.

- The branch name can safely start with `v` - and it actually should - because the tags are created after the deletion of the branch.

- The requirements discussed for [detect-branch-version](../detect-branch-version/README.md) also apply.

## 💡How it works

1. By default, delete the current Git branch.

1. Create a new tag - for example, `vX.Y.Z` - containing the semantic version inferred from the branch name.

1. Generate the release notes - based on the Git commit list

1. If `notes-file-processor` is not an empty string, it will be interpreted as the filename - relative to `project-directory` - of a **Bash** script that:

   - must take in input (via `$1`) the path of the temporary file containing the generated release notes

   - can arbitrarily alter the content of such file - and even call other interpreters

   - does not need the `#!` prelude, nor the _executable flag_

1. Create or draft a GitHub release.

1. Optionally, _create or move_ the tag of the major version related to the current version - for example, `vX`.

## 📥Inputs

|          Name          |    Type     |                        Description                        | Default value |
| :--------------------: | :---------: | :-------------------------------------------------------: | :-----------: |
|      `draft-only`      | **boolean** |        Only draft the release - do not publish it         |   **false**   |
| `notes-file-processor` | **string**  |      Bash script editing the generated release notes      |               |
|    `set-major-tag`     | **boolean** | Create/move the `vX` tag to this commit (X=major version) |   **false**   |
|       `dry-run`        | **boolean** |        Run the action without performing commands         |   **false**   |

## 📤Outputs

|     Name      |    Type    |               Description                |  Example   |
| :-----------: | :--------: | :--------------------------------------: | :--------: |
| `release-tag` | **string** | The Git tag associated with the release  | **v7.4.9** |
|  `major-tag`  | **string** | The Git tag of the major version, if set |   **v7**   |

## 🌐Further references

- [semver](https://semver.org/)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
