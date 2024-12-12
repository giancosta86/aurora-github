# verify-rust-wasm

Verifies the source files of a **Rust** web assembly.

## 🃏Example

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-rust-wasm@v8
    with:
      wasm-pack-version: 0.13.1
      npm-scope: your-npm-scope
```

## 💡How it works

1. Invoke the [install-wasm-pack](../install-wasm-pack/README.md) action, passing all the matching inputs, to install the `wasm-pack` command.

1. Invoke the [verify-rust-crate](../verify-rust-crate/README.md) action, passing all the matching inputs, to perform code analysis over the Rust source code.

1. Run `wasm-pack test` to run headless browser tests on Chrome.

1. Invoke [generate-wasm-target](../generate-wasm-target/README.md) to generate the NodeJS package source files in the **pkg** subdirectory.

1. If the directory referenced by the `client-tests-directory` input exists, execute the [run-custom-tests](../run-custom-tests/README.md) action on it, with the `optional` flag enabled.

## ☑️Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [check-rust-versions](../check-rust-versions/README.md)

- Please, refer to the documentation of [run-custom-tests](../run-custom-tests/README.md) for details about setting up a suitable structure for `client-tests-directory`.

## 📥Inputs

|           Name            |          Type           |                    Description                    |       Default value       |
| :-----------------------: | :---------------------: | :-----------------------------------------------: | :-----------------------: |
|    `wasm-pack-version`    |       **string**        |        The `wasm-pack` version to install         |                           |
|        `npm-scope`        |       **string**        |         The npm package scope or `<ROOT>`         |                           |
| `client-tests-directory`  |       **string**        |  Relative directory containing the client tests   |     **client-tests**      |
|       `wasm-target`       |       **string**        |    The target of the `wasm-pack build` command    |          **web**          |
|    `run-clippy-checks`    |       **boolean**       |             Enable linting via Clippy             |         **true**          |
|      `check-rustdoc`      |       **boolean**       | Build the documentation - with warnings as errors |         **false**         |
| `crash-on-critical-todos` |       **boolean**       |  Crash the workflow if critical TODOs are found   |         **true**          |
|    `source-file-regex`    |       **string**        |     PCRE pattern describing the source files      | view [source](action.yml) |
| `enforce-branch-version`  | `inject`,`check`,`skip` |     How the branch version should be enforced     |        **inject**         |
|    `project-directory`    |       **string**        |       The directory containing `Cargo.toml`       |           **.**           |

## 🌐Further references

- [generate-wasm-target](../generate-wasm-target/README.md)

- [run-custom-tests](../run-custom-tests/README.md)

- [parse-npm-scope](../parse-npm-scope/README.md)

- [check-rust-versions](../check-rust-versions/README.md)

- [install-wasm-pack](../install-wasm-pack/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [enforce-branch-version](../enforce-branch-version/README.md)

- [aurora-github](../../README.md)
