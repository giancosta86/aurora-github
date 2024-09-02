# validate-npm-package

Validates the source files of a NodeJS package - by running its `validate` script - which is especially useful as a condition for merging a pull request.

It is worth noting that the action can support any underlying technology - as long as you comply with the requirements described below.

## Requirements

- The project's package manager must be [pnpm](https://pnpm.io/).

- The `pnpm-lock.yaml` file must be committed into the repository.

- The entire validation process for the package must be triggered by the `validate` script in `package.json` (see the example below).

- The root directory of the project must contain a `.nvmrc` file - declaring the required Node.js version - whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`).

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/validate-npm-package
```

**IMPORTANT**: please, remember to declare your validation process in the `validate` script within `package.json`! For example:

```json
"scripts": {
  "build": "tsc",
  "test": "vitest",
  "validate": "pnpm test && pnpm build"
}
```

## Inputs

|           Name           |    Type     |                            Description                             | Default value |
| :----------------------: | :---------: | :----------------------------------------------------------------: | :-----------: |
| `check-artifact-version` | **boolean** | Runs [check-artifact-version](../check-artifact-version/README.md) |   **true**    |
|      `pnpm-version`      | **boolean** |                   The version of **pnpm** to use                   |     **9**     |
|   `project-directory`    | **string**  |               The directory containing `Cargo.toml`                |     **.**     |
|         `shell`          | **string**  |                   The shell used to run commands                   |   **bash**    |

## Further references

- [aurora-github](../../README.md)
