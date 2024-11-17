# publish-rust-wasm

Publishes a **Rust** web assembly to an [npm](https://www.npmjs.com/) registry.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-wasm@v7
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
      wasm-pack-version: 0.13.0
      npm-scope: your-npm-scope
```

**Please, note**: this action is designed for _publication_ only - not for verification: you might want to use [verify-rust-wasm](../verify-rust-wasm/README.md) for that.

## Requirements

- You must create a `.nvmrc` file, declaring the required Node.js version, whose format must be compatible with the [setup-nodejs-context](../setup-nodejs-context/README.md) action (for example: `vX.Y.Z`): such file will most probably reside in a `client-tests` subdirectory - designed for NodeJS tests - but you can customize this aspect via the `node-version-directory` input.

- `npm-token` is _not_ mandatory when `dry-run` is enabled.

- The requirements for [publish-npm-package](../publish-npm-package/README.md).

- The requirements for [publish-github-pages](../publish-github-pages/README.md) if `website-directory` references an existing directory.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs 📥

|           Name           |    Type     |                    Description                    |  Default value   |
| :----------------------: | :---------: | :-----------------------------------------------: | :--------------: |
|        `dry-run`         | **boolean** |    Run a simulated publication via `--dry-run`    |    **false**     |
|       `npm-token`        | **string**  |  The secret token for publishing to the registry  |                  |
|   `wasm-pack-version`    | **string**  |        The `wasm-pack` version to install         |                  |
|       `npm-scope`        | **string**  |         The npm package scope or `<ROOT>`         |                  |
|      `wasm-target`       | **string**  |    The target of the `wasm-pack build` command    |     **web**      |
| `node-version-directory` | **string**  |  Relative directory containing the `.nvmrc` file  | **client-tests** |
|   `website-directory`    | **string**  | Relative directory containing the project website |   **website**    |
|   `project-directory`    | **string**  |       The directory containing `Cargo.toml`       |      **.**       |

## Further references

- [publish-npm-package](../publish-npm-package/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

- [parse-npm-scope](../parse-npm-scope/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
