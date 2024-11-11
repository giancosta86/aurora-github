# publish-github-pages

Publishes a directory as the [GitHub Pages](https://pages.github.com/) website for the current repository.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-github-pages@v6
```

**Please, note:** this action is automatically run by [publish-npm-package](../publish-npm-package/README.md), [publish-rust-crate](../publish-rust-crate/README.md) and [publish-rust-wasm](../publish-rust-wasm/README.md).

## How it works

1. If `source-directory` is set to an empty string (the default) or refers to a missing directory, if `optional` is set to **true** the action will simply exit, otherwise the workflow will fail.

1. If `source-directory` contains a **package.json** file:

   1. set up a NodeJS environment via [setup-nodejs-context](../setup-nodejs-context/README.md)

   1. run `pnpm build`

   1. the **dist** subdirectory will be the actual website source

1. If `dry-run` is set to **true**, interrupt the process without failing

1. Publish the files to GitHub Pages

## Requirements

- The following [permissions](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work:

  - `pages`: **write**

  - `id-token`: **write**

  **Please, note:** at the same time, you may want to _declare your required default permissions_ - such as `contents`, necessary for some Git operations - because, otherwise, they would be disabled by an explicit `permissions` block.

- **GitHub Pages** must be enabled for the current repository - and having GitHub Actions as their **source**.

- It is recommended that GitHub Actions have **read/write** permissions on the repository.

- Please, refer to [setup-nodejs-context](../setup-nodejs-context/README.md) for details about setting up a NodeJS environment.

## Inputs 📥

|        Name        |    Type     |                           Description                           | Default value |
| :----------------: | :---------: | :-------------------------------------------------------------: | :-----------: |
| `source-directory` | **string**  |                Directory containing the website                 |               |
|     `optional`     | **boolean** | `source-directory` can be empty or refer to a missing directory |   **false**   |
|     `dry-run`      | **boolean** |           Stops the publication just before uploading           |   **false**   |
|      `shell`       | **string**  |                 The shell used to run commands                  |   **bash**    |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [GitHub Pages](https://pages.github.com/)

- [aurora-github](../../README.md)
