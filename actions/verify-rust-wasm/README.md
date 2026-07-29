# verify-rust-wasm

Verifies the source files of a **Rust** web assembly.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/verify-rust-wasm@v11
    with:
      wasm-pack-version: 0.13.1
      npm-scope: your-npm-scope
```

## 💡 How it works

1. Call [setup-nodejs-context](../setup-nodejs-context/README.md) based on `working-directory`, without installing dependencies.

1. Ensure the `wasm-pack` command at `wasm-pack-version` is available.

1. Invoke the [verify-rust-crate](../verify-rust-crate/README.md) action, passing all the matching inputs, to perform code analysis over the Rust source code.

1. Run `wasm-pack test` to run headless browser tests on Chrome.

1. Generate the NodeJS package source files in the **pkg** subdirectory. In particular:
   - if `node-version` is passed, it will be injected into the `engines/node` field in **package.json**

   - if `package-manager` is passed, it will be injected into the `packageManager` field in **package.json**

1. If `working-directory` contains **.npmrc**, copy it to **pkg**.

1. Run [inject-branch-version](../inject-branch-version/README.md) on **pkg/package-json**

1. If the directory referenced by the `client-tests-directory` input exists:
   1. Install their dependencies

   1. Execute the tests via the package manager's `test` command.

## ☑️ Requirements

- `rust-toolchain.toml` must be present in `working-directory` - as described in [setup-rust-context](../setup-rust-context/README.md)

## 📥 Inputs

|           Name           |    Type     |                     Description                     |                                      Default value                                       |
| :----------------------: | :---------: | :-------------------------------------------------: | :--------------------------------------------------------------------------------------: |
|   `wasm-pack-version`    | **string**  |           `wasm-pack` version to install            |                                                                                          |
|      `wasm-target`       | **string**  |       Target of the `wasm-pack build` command       |                                         **web**                                          |
|       `npm-scope`        | **string**  |           npm package scope, or `<ROOT>`            |                                                                                          |
|      `node-version`      | **string**  |               Required NodeJS version               |                                                                                          |
|    `package-manager`     | **string**  |     Required package manager, with `@` version      |                                                                                          |
| `client-tests-directory` | **string**  |   Relative directory containing the client tests    |                                     **client-tests**                                     |
|       `run-clippy`       | **boolean** |              Enable linting via Clippy              |                                         **true**                                         |
|     `check-rustdoc`      | **boolean** |  Build the documentation - with warnings as errors  |                                        **false**                                         |
|       `todo-files`       | **string**  | File patterns potentially containing critical TODOs | **{{src tests}/\*\*[nomatch-ok].rs client-tests/\*\*[nomatch-ok].{'' c m}{j t}s{'' x}}** |

| `working-directory` | **string** | Directory containing **Cargo.toml** | **.** |

## 🌐 Further references

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
