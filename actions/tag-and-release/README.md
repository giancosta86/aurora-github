# tag-and-release

Creates a **Git** tag and a **GitHub** _draft_ release when merging a pull request, in addition to updating a _major version branch_, from a Git branch named according to [semantic versioning](https://semver.org/).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/tag-and-release@v11
```

It is essential to remember that this action should be associated with this trigger:

```yaml
on:
  pull_request:
    types: [closed]
```

For any trigger different from a **merged** pull request, the action will merely print out an informational message.

## 💡 How it works

1. If the action is not triggered by a **merged** pull request, just display a message and exit the action.

1. Parse a **semantic version** from the _branch name_ (e.g.: **v7.2.0**, or just **7.2.0**, or even **7.2**)

1. **Delete** the merged branch from the repository.

1. Create a new tag - always having form `v<major>.<minor>.<patch>` - based on the parsed version, then push it.

1. Create a **release draft** with _auto-generated notes_. The release title will be `<product name> <major>.<minor>.<patch>`, where `product-name` will be the related input value, defaulting to the _repository name_.

1. If `update-major-branch` is enabled:
   1. Create the `v<major>` branch if it does not already exist, then switch to it

   1. Merge with the `v<major>.<minor>.<patch>` tag created above

   1. Push the updated `v<major>` branch

## 💬 Remarks

The action is **idempotent**; in particular, _if the merged branch has been deleted_ by a previous run, or the tag and the release have already been created, the job containing the action **can be re-run**.

## ☑️ Requirements

- The following [permission](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work
  - `contents`: **write**

  It is active by default - but it must be explicitly enabled when other permissions are declared

- Within the **Settings** tab of the project web interface on GitHub, the following **Workflow permissions** must be selected:
  - **Read and write permissions**

## 📥 Inputs

|         Name          |    Type     |                          Description                           | Default value |
| :-------------------: | :---------: | :------------------------------------------------------------: | :-----------: |
|    `product-name`     | **string**  | Name of the product; if empty, defaults to the repository name |               |
| `update-major-branch` | **boolean** |             Create/update the 'v\<major\>' branch              |   **true**    |

## 📤 Outputs

|      Name      |    Type    |                         Description                          |  Example   |
| :------------: | :--------: | :----------------------------------------------------------: | :--------: |
|     `tag`      | **string** |               Git tag created for the release                | **v7.4.9** |
| `major-branch` | **string** | Git branch of the major version, if updated; empty otherwise |   **v7**   |

## 🌐 Further references

- [semver](https://semver.org/)

- [detect-branch-version](../detect-branch-version/README.md)

- [aurora-github](../../README.md)
