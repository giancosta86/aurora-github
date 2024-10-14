# tag-and-release

Creates a **Git** tag and a **GitHub** release, from a Git branch named according to [semver](https://semver.org/); by default, it also deletes the current branch.

## Example

This action is designed to be the very last step in a _publication_ workflow:

```yaml
steps:
  - uses: PUBLICATION STEP 1

  - uses: PUBLICATION STEP 2

  - uses: PUBLICATION STEP N

  - uses: giancosta86/aurora-github/actions/tag-and-release@v4
```

## Requirements

- The following [permission](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work - especially during the _branch deletion_ process:

  - `contents`: **write**

  It is already active by default - but declaring other permissions will implictly disable it.

- GitHub Actions must have **read/write** permissions on the repository.

- this action will not run on the _default_ branch of the repository.

- the branch name can safely start with `v`, as long as `delete-branch` is **true** (the default), because the tags are created after the deletion of the branch.

- the ones discussed for [detect-branch-version](../detect-branch-version/README.md).

## How it works

1. By default, delete the current Git branch.

1. Create a new tag - for example, `vX.Y.Z` - containing the semantic version inferred from the branch name.

1. Create or draft a GitHub release.

1. Optionally, _create or move_ the tag of the major version related to the current version - for example, `vX`.

## Inputs 📥

|      Name       |    Type     |                        Description                        | Default value |
| :-------------: | :---------: | :-------------------------------------------------------: | :-----------: |
|  `draft-only`   | **boolean** |                  Only draft the release                   |   **false**   |
| `delete-branch` | **boolean** |         Delete the branch after creating the tag          |   **true**    |
| `set-major-tag` | **boolean** | Create/move the `vX` tag to this commit (X=major version) |   **false**   |
|     `shell`     | **string**  |              The shell used to run commands               |   **bash**    |

## Further references

- [semver](https://semver.org/)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
