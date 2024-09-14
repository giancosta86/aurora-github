# publish-npm-package

Publishes a **NodeJS** package to the [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package@v3
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**Please, note**: this action is designed for _publication_ only - not for _verification_: you may want use [verify-npm-package](../verify-npm-package/README.md) for that; as a plus, you can add publication-specific checks via the [pre-/post- hook scripts](https://docs.npmjs.com/cli/v10/using-npm/scripts) of your `package.json` file.

## Requirements

- The project's package manager must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs

|        Name         |    Type     |                   Description                   | Default value |
| :-----------------: | :---------: | :---------------------------------------------: | :-----------: |
|     `npm-token`     | **string**  |     The secret token for publishing to npm      |               |
|      `dry-run`      | **boolean** |   Run a simulated publication via `--dry-run`   |   **false**   |
|  `frozen-lockfile`  | **boolean** | Fail if `pnpm-lock.yaml` is missing or outdated |   **true**    |
| `project-directory` | **string**  |     The directory containing `package.json`     |     **.**     |
|       `shell`       | **string**  |         The shell used to run commands          |   **bash**    |

## Further references

- [verify-npm-package](../verify-npm-package/README.md)

- [aurora-github](../../README.md)
