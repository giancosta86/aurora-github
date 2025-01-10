# publish-github-pages

Publishes a directory as the [GitHub Pages](https://pages.github.com/) website for the current repository.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-github-pages@v9
```

**Please, note**: this action is automatically run by:

- [publish-jvm-project](../publish-jvm-project/README.md)


- [publish-npm-package](../publish-npm-package/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md).

## 💡How it works

1. If `source-directory` is set to an empty string (the default) or refers to a missing directory, if `optional` is set to **true** the action will simply exit, otherwise the workflow will fail.

1. If `source-directory` contains:

   - a **package.json** file:

     1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

     1. Set up a NodeJS environment via [setup-nodejs-context](../setup-nodejs-context/README.md) in `source-directory`.

     1. Run `pnpm build`.

     1. The **dist** subdirectory will contain the actual website.

   - a **pom.xml** file:

     1. Run [enforce-branch-version](../enforce-branch-version/README.md), forwarding the `enforce-branch-version` input to its `mode` input.

     1. Run `mvn site`.

     1. The **target/site** subdirectory will contain the actual website.

1. If `dry-run` is set to **true**, interrupt the process without failing.

1. Publish the files to GitHub Pages.

## ☑️Requirements

- The following [permissions](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work:

  - `pages`: **write**

  - `id-token`: **write**

  **Please, note**: at the same time, you may want to _declare your required default permissions_ - such as `contents`, necessary for some Git operations - because, otherwise, they would be disabled by an explicit `permissions` block.

- **GitHub Pages** must be enabled for the current repository - and having GitHub Actions as their **source**.

- It is recommended that GitHub Actions have **read/write** permissions on the repository.

- Please, refer to [setup-nodejs-context](../setup-nodejs-context/README.md) for details about setting up a NodeJS environment.

## 📥Inputs

|           Name           |          Type           |                             Description                             | Default value |
| :----------------------: | :---------------------: | :-----------------------------------------------------------------: | :-----------: |
|    `source-directory`    |       **string**        |                  Directory containing the website                   |     **.**     |
|        `optional`        |       **boolean**       | Whether `source-directory` can be empty string or missing directory |   **false**   |
| `enforce-branch-version` | `inject`,`check`,`skip` |              How the branch version should be enforced              |  **inject**   |
|        `dry-run`         |       **boolean**       |             Stop the publication just before uploading              |   **false**   |

## 📤Outputs

| Name  |    Type    |           Description            |   Example   |
| :---: | :--------: | :------------------------------: | :---------: |
| `url` | **string** | The URL of the published website | _HTTPS url_ |

## 🌐Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [publish-rust-crate](../publish-rust-crate/README.md)

- [publish-rust-wasm](../publish-rust-wasm/README.md)

- [GitHub Pages](https://pages.github.com/)

- [aurora-github](../../README.md)
