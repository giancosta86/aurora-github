# publish-rust-wasm

Publishes a **Rust** web assembly to an [npm](https://www.npmjs.com/) registry.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-rust-wasm@v11
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
      wasm-pack-version: 0.13.1
      npm-scope: your-npm-scope
```

**Please, note**: this action is designed for _publication_ only - not for verification: you might want to use [verify-rust-wasm](../verify-rust-wasm/README.md) for that.

## 💡 How it works

1. Call [setup-nodejs-context](../setup-nodejs-context/README.md), based on `working-directory`

1. Install the `wasm-pack` command at `wasm-pack-version`.

1. Generate the NodeJS package source files in the **pkg** subdirectory. In particular:
   - if `node-version` is passed, it will be injected into the `engines/node` field in **package.json**

   - if `package-manager` is passed, it will be injected into the `packageManager` field in **package.json**

1. If `working-directory` contains **.npmrc**, copy it to **pkg**.

1. Run [inject-branch-version](../inject-branch-version/README.md) to inject the branch version into **pkg/package-json**

1. Call [publish-npm-package](../publish-npm-package/README.md) on the **pkg** directory - passing all the matching inputs - to publish the npm package.

## ☑️ Requirements

- `npm-token` is **mandatory** - unless `dry-run` is enabled

- The requirements for [publish-npm-package](../publish-npm-package/README.md).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥 Inputs

|        Name         |    Type     |                   Description                   | Default value |
| :-----------------: | :---------: | :---------------------------------------------: | :-----------: |
|      `dry-run`      | **boolean** |   Run a simulated publication via `--dry-run`   |   **false**   |
|     `npm-token`     | **string**  | The secret token for publishing to the registry |               |
| `wasm-pack-version` | **string**  |       The `wasm-pack` version to install        |               |
|     `npm-scope`     | **string**  |        The npm package scope or `<ROOT>`        |               |
|   `node-version`    | **string**  |           The required NodeJS version           |               |
|  `package-manager`  | **string**  |   The required package manager, with version    |               |
|    `wasm-target`    | **string**  |   The target of the `wasm-pack build` command   |    **web**    |
| `working-directory` | **string**  |      The directory containing `Cargo.toml`      |     **.**     |

## 🌐 Further references

- [publish-npm-package](../publish-npm-package/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
