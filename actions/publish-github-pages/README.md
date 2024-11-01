# publish-github-pages

Publishes a directory as the [GitHub Pages](https://pages.github.com/) website for the current repository.

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-github-pages@v5
```

## Requirements

- The following [permissions](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/controlling-permissions-for-github_token) must be set for the action to work:

  - `pages`: **write**

  - `id-token`: **write**

  **Please, note:** at the same time, you may want to _declare your required default permissions_ - such as `contents`, necessary for some Git operations - because, otherwise, they would be disabled by an explicit `permissions` block.

- **GitHub Pages** must be enabled for the current repository - and having GitHub Actions as their **source**.

- It is recommended that GitHub Actions have **read/write** permissions on the repository.

## Inputs 📥

|        Name        |    Type    |                Description                | Default value |
| :----------------: | :--------: | :---------------------------------------: | :-----------: |
| `source-directory` | **string** | Relative directory containing the website |  **website**  |
|      `shell`       | **string** |      The shell used to run commands       |   **bash**    |

## Further references

- [GitHub Pages](https://pages.github.com/)

- [aurora-github](../../README.md)
