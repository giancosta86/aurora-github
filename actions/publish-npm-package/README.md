# publish-npm-package

Publishes a NodeJS package to the [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-npm-package
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**IMPORTANT**: please, remember that the action is designed for **publication** only - not for validation - although you can add publication-specific checks to the `prepack` or `postpack` scripts of your `package.json` file.

## Requirements

- The project's package manager must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

## Inputs

|        Name         |    Type     |                   Description                    | Default value |
| :-----------------: | :---------: | :----------------------------------------------: | :-----------: |
|  `frozen-lockfile`  | **boolean** | Fails if `pnpm-lock.yaml` is missing or outdated |   **true**    |
|     `npm-token`     | **string**  |         The secret token provided by npm         |     **9**     |
| `project-directory` | **string**  |      The directory containing `Cargo.toml`       |     **.**     |
|       `shell`       | **string**  |          The shell used to run commands          |   **bash**    |

## Further references

- [aurora-github](../../README.md)
