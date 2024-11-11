# verify-rust-wasm

Verifies the source files of a **Rust** web assembly.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-rust-wasm@v6
    with:
      wasm-pack-version: 0.13.0
      npm-scope: your-npm-scope
```

## How it works

1. Invoke the [install-wasm-pack](../install-wasm-pack/README.md) action, passing all the matching inputs, to install the `wasm-pack` command.

1. Invoke the [verify-rust-crate](../verify-rust-crate/README.md) action, passing all the matching inputs, to perform code analysis over the Rust source code.

1. Run `wasm-pack test` to run headless browser tests on Chrome.

1. Run `wasm-pack build` to verify the generation of the NodeJS package source files.

1. If the directory referenced by the `client-tests-directory` input exists, execute the [run-custom-tests](../run-custom-tests/README.md) action on it, with the `optional` flag enabled.

## Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [check-rust-versions](../check-rust-versions/README.md)

- Please, refer to the documentation of [run-custom-tests](../run-custom-tests/README.md) for details about setting up a suitable structure for `client-tests-directory`.

## Inputs 📥

|           Name            |    Type     |                       Description                        |         Default value         |
| :-----------------------: | :---------: | :------------------------------------------------------: | :---------------------------: |
|    `wasm-pack-version`    | **string**  |            The `wasm-pack` version to install            |                               |
|        `npm-scope`        | **string**  |            The npm package scope or `<ROOT>`             |                               |
| `client-tests-directory`  | **string**  |      Relative directory containing the client tests      |       **client-tests**        |
|       `wasm-target`       | **string**  |       The target of the `wasm-pack build` command        |            **web**            |
|    `run-clippy-checks`    | **boolean** |                Enable linting via Clippy                 |           **true**            |
|      `check-rustdoc`      | **boolean** |    Build the documentation - with warnings as errors     |           **false**           |
| `crash-on-critical-todos` | **boolean** |      Crash the workflow if critical TODOs are found      |           **true**            |
|    `source-file-regex`    | **string**  |         PCRE pattern describing the source files         | view the [code](./action.yml) |
| `check-artifact-version`  | **boolean** | Ensure the version in Cargo.toml matches the branch name |           **true**            |
|    `project-directory`    | **string**  |          The directory containing `Cargo.toml`           |             **.**             |
|          `shell`          | **string**  |              The shell used to run commands              |           **bash**            |

## Further references

- [run-custom-tests](../run-custom-tests/README.md)

- [parse-npm-scope](../parse-npm-scope/README.md)

- [check-rust-versions](../check-rust-versions/README.md)

- [install-wasm-pack](../install-wasm-pack/README.md)

- [check-artifact-version](../check-artifact-version/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
