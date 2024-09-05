# publish-rust-wasm

Publishes a **Rust** web assembly to the [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-wasm@v2
    with:
      npm-scope: your-npm-scope
      npm-token: ${{ secrets.NPM_TOKEN }}
```

**Please, note**: this action is designed for **publication** only - not for validation: you can use [validate-rust-wasm](../validate-rust-wasm/README.md) instead.

## Requirements

- You must create a `.nvmrc` file, declaring the required Node.js version, whose format must be compatible with the `actions/setup-node` action (for example: `vX.Y.Z`): the file will most probably reside in a `client-tests` subdirectory - designed for NodeJS tests - but you can customize this aspect via the `node-version-directory` input.

## Inputs

|           Name           |    Type     |                           Description                           |  Default value   |
| :----------------------: | :---------: | :-------------------------------------------------------------: | :--------------: |
|       `npm-scope`        | **string**  | The npm package scope (**without** the initial `@`) - or empty. |                  |
|       `npm-token`        | **string**  |                The secret token provided by npm                 |                  |
|      `wasm-target`       | **string**  |           The target of the 'wasm-pack build' command           |     **web**      |
|        `dry-run`         | **boolean** |            Run a simulated publication via --dry-run            |    **false**     |
| `node-version-directory` | **string**  |        The relative directory containing the .nvmrc file        | **client-tests** |
|   `project-directory`    | **string**  |              The directory containing `Cargo.toml`              |      **.**       |
|         `shell`          | **string**  |                 The shell used to run commands                  |     **bash**     |

## Further references

- [validate-rust-wasm](../validate-rust-wasm/README.md) instead

- [aurora-github](../../README.md)
