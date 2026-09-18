# publish-rust-wasm

Publishes a **Rust** web assembly to an [npm](https://www.npmjs.com/) registry.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/publish-rust-wasm@v13
    with:
      npm-token: ${{ secrets.NPM_TOKEN }}
      wasm-pack-version: 0.13.1
      npm-scope: your-npm-scope, or <ROOT>
```

**Please, note**: this action is designed for _publication_ only - not for verification: you might want to use [verify-rust-wasm](../verify-rust-wasm/README.md) for that.

## 💡 How it works

1. Call [setup-nodejs-context](../setup-nodejs-context/README.md), based on `working-directory`, without installing dependencies.

1. Install the `wasm-pack` command at `wasm-pack-version`.

1. Generate the NodeJS package source files in the **pkg** subdirectory.

1. **If** a **package.json** was generated, **merge** the **package.json** in `working-directory` **on top of it**.

1. If `working-directory` contains **.npmrc**, copy it to **pkg**.

1. Run [inject-branch-version](../inject-branch-version/README.md) to inject the branch version into **pkg/package-json**

1. Call [publish-npm-package](../publish-npm-package/README.md) on the **pkg** directory - passing all the matching inputs - to publish the npm package.

## ☑️ Requirements

- `npm-token` is **mandatory** - unless `dry-run` is enabled

- **package.json** must be present in `working-directory`, declaring at least a _NodeJS version_ and a _package manager_, which are required to run [setup-nodejs-context](../setup-nodejs-context/README.md); it is worth noting that such file will be merged on top of any generated **package.json**.

- The requirements for [publish-npm-package](../publish-npm-package/README.md).

- Before the first publication, running with `dry-run` set to **true** is recommended.

## 📥 Inputs

|        Name         |    Type     |                 Description                 | Default value |
| :-----------------: | :---------: | :-----------------------------------------: | :-----------: |
|      `dry-run`      | **boolean** | Run a simulated publication via `--dry-run` |   **false**   |
|     `npm-token`     | **string**  | Secret token for publishing to the registry |               |
| `wasm-pack-version` | **string**  |       `wasm-pack` version to install        |               |
|    `wasm-target`    | **string**  |   Target of the `wasm-pack build` command   |    **web**    |
|     `npm-scope`     | **string**  |        npm package scope or `<ROOT>`        |               |
| `working-directory` | **string**  |      Directory containing `Cargo.toml`      |     **.**     |

## 🌐 Further references

- [publish-npm-package](../publish-npm-package/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
