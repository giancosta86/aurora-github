# verify-npm-package

Verifies the source files of a **NodeJS** package - by running its `verify` script within the `scripts` section of `package.json`.

It is worth noting this action can support any technology - as long as you comply with the requirements described below.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-npm-package@v2
```

**IMPORTANT**: please, remember to declare your verification process in the `verify` script within `package.json`! For example:

```json
"scripts": {
  "test": "vitest",
  "build": "tsc",
  "verify": "pnpm test && pnpm build"
}
```

## Requirements

- The package manager for the project must be [pnpm](https://pnpm.io/) - version `9` or later compatible.

- The entire verification process for the package must be triggered by the `verify` script in `package.json` (see the example).

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

- The requirements for [check-artifact-version](../check-artifact-version/README.md), if `check-artifact-version` is enabled.

## Inputs

|           Name           |    Type     |                         Description                          | Default value |
| :----------------------: | :---------: | :----------------------------------------------------------: | :-----------: |
|    `frozen-lockfile`     | **boolean** |       Fails if `pnpm-lock.yaml` is missing or outdated       |   **true**    |
| `check-artifact-version` | **boolean** | Ensure the version in `package.json` matches the branch name |   **true**    |
|   `project-directory`    | **string**  |           The directory containing `package.json`            |     **.**     |
|         `shell`          | **string**  |                The shell used to run commands                |   **bash**    |

## Further references

- [check-artifact-version](../check-artifact-version/README.md)

- [aurora-github](../../README.md)
