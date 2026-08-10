# publish-github-pages

Publishes a directory as the [GitHub Pages](https://pages.github.com/) website for the current repository.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-github-pages@v11
```

## 💡 How it works

1. Run [inject-branch-version](../inject-branch-version/README.md) on any descriptor supported in the steps below.

1. If `working-directory` contains:
   - a **package.json** file:
     1. Run [verify-npm-package](../verify-npm-package/README.md) - which, in particular, executes the `build` script in **package.json**.

     1. The **dist** subdirectory will contain the actual website.

   - a **pom.xml** file:
     1. Run `mvn site`.

     1. The **target/site** subdirectory will contain the actual website.

   - otherwise, the entire directory will be considered a **static** website.

1. If `dry-run` is set to **true**, stop the process without actually publishing.

1. Publish the files to GitHub Pages.

## ☑️ Requirements

- **GitHub Pages** must be enabled for the current repository - and having GitHub Actions as their **source**.

- The following [permissions](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work:
  - `pages`: **write**

  - `id-token`: **write**

  **Please, note**: at the same time, you may want to _declare your required default permissions_ - such as `contents`, necessary for some Git operations - because, otherwise, they would be disabled by an explicit `permissions` block.

- It is recommended that GitHub Actions have **read/write** permissions on the repository.

## 📥 Inputs

|        Name         |    Type     |                            Description                             | Default value |
| :-----------------: | :---------: | :----------------------------------------------------------------: | :-----------: |
|   `check-license`   | **boolean** |                 Run checks on the project license                  |   **true**    |
| `corepack-version`  | **string**  | Version of corepack to install for a NodeJS website, empty to skip |  **latest**   |
|   `java-version`    | **string**  |               Java version to use for Java websites                |               |
| `java-tool-version` | **string**  |               Tool version to use for Java websites                |               |
|      `dry-run`      | **boolean** |             Stop the publication just before uploading             |   **false**   |
| `working-directory` | **string**  |        Directory containing the website or its source files        |     **.**     |

## 📤 Outputs

| Name  |    Type    |         Description          |   Example   |
| :---: | :--------: | :--------------------------: | :---------: |
| `url` | **string** | URL of the published website | _HTTPS url_ |

## 🌐 Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [GitHub Pages](https://pages.github.com/)

- [aurora-github](../../README.md)
