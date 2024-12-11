# publish-rust-wasm

Publishes a **Rust** web assembly to an [npm](https://www.npmjs.com/) registry.

## Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/publish-rust-wasm@v8
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
      wasm-pack-version: 0.13.1
      npm-scope: your-npm-scope
```

**Please, note**: this action is designed for _publication_ only - not for verification: you might want to use [verify-rust-wasm](../verify-rust-wasm/README.md) for that.

## How it works

1. Invoke the [install-wasm-pack](../install-wasm-pack/README.md) action, passing all the matching inputs, to install the `wasm-pack` command.

1. Invoke [generate-wasm-target](../generate-wasm-target/README.md) to generate the NodeJS package source files in the **pkg** subdirectory.

1. If a `.npmrc` configuration file exists in `project-directory`, copy it to **pkg**

1. Call [publish-npm-package](../publish-npm-package/README.md) on the **pkg** directory - passing all the matching inputs - to publish the npm package.

## Requirements

- the `nodejs-version` input is required for the build process; optionally, you can set the `pnpm-version` input as well, in order to request a specific pnpm version.

- `npm-token` is **mandatory** - unless `dry-run` is enabled

- The requirements for [publish-npm-package](../publish-npm-package/README.md).

- The requirements for [publish-github-pages](../publish-github-pages/README.md) if `website-directory` references an existing directory.

- Before the first publication, running with `dry-run` set to **true** is recommended.

## Inputs 📥

|           Name           |          Type           |                        Description                         | Default value |
| :----------------------: | :---------------------: | :--------------------------------------------------------: | :-----------: |
|        `dry-run`         |       **boolean**       |        Run a simulated publication via `--dry-run`         |   **false**   |
|       `npm-token`        |       **string**        |      The secret token for publishing to the registry       |               |
|   `wasm-pack-version`    |       **string**        |             The `wasm-pack` version to install             |               |
|       `npm-scope`        |       **string**        |             The npm package scope or `<ROOT>`              |               |
|     `nodejs-version`     |       **string**        |      The `engines / node` version within package.json      |               |
|      `pnpm-version`      |       **string**        | The `packageManager` reference to pnpm within package.json |               |
|      `wasm-target`       |       **string**        |        The target of the `wasm-pack build` command         |    **web**    |
|   `website-directory`    |       **string**        |     Relative directory containing the project website      |  **website**  |
| `enforce-branch-version` | `inject`,`check`,`skip` |         How the branch version should be enforced          |  **inject**   |
|   `project-directory`    |       **string**        |           The directory containing `Cargo.toml`            |     **.**     |

## Further references

- [generate-wasm-target](../generate-wasm-target/README.md)

- [publish-npm-package](../publish-npm-package/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [publish-github-pages](../publish-github-pages/README.md)

- [parse-npm-scope](../parse-npm-scope/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [aurora-github](../../README.md)
