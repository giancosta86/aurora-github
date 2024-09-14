# verify-rust-wasm

Verifies the source files of a **Rust** web assembly.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/verify-rust-wasm@v3
    with:
      wasm-pack-version: 0.13.0
      npm-scope: your-npm-scope
```

## How it works

1. Invoke the [install-wasm-pack](../install-wasm-pack/README.md) action, passing all the matching inputs, to install the `wasm-pack` command.

1. Invoke the [verify-rust-crate](../verify-rust-crate/README.md) action, passing all the matching inputs, to perform code analysis over the Rust source code.

1. Run `wasm-pack test` to run headless browser tests on Chrome.

1. Run `wasm-pack build` to verify the generation of the NodeJS package source files.

1. If the `client-tests-directory` input parameter is not an empty string:

   1. Ensure the directory really exists

   1. `cd` to that directory

   1. Install its dependencies

   1. Execute `pnpm verify` to run the NodeJS-based client tests

## Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [check-rust-versions](../check-rust-versions/README.md)

- if `client-tests-directory` is not an empty string, it must be the **relative path** of a directory containing:

  - a `.nvmrc` file, with the requested Node.js version

  - a `package.json` descriptor having:

    - a `verify` script, in the `scripts` section

    - as usual, all the dependencies required by the tests

  - an updated `pnpm-lock.yaml` lockfile

## Inputs

|           Name           |    Type     |                         Description                          |  Default value   |
| :----------------------: | :---------: | :----------------------------------------------------------: | :--------------: |
|   `wasm-pack-version`    | **string**  |              The `wasm-pack` version to install              |                  |
|       `npm-scope`        | **string**  | The npm package scope (**without** the initial `@`) or empty |                  |
| `client-tests-directory` | **string**  | Relative directory containing the NodeJS-based client tests  | **client-tests** |
|      `wasm-target`       | **string**  |         The target of the `wasm-pack build` command          |     **web**      |
|   `run-clippy-checks`    | **boolean** |                  Enable linting via Clippy                   |     **true**     |
|     `run-doc-checks`     | **boolean** |      Run documentation checks - with warnings as errors      |    **false**     |
| `check-artifact-version` | **boolean** |   Ensure the version in Cargo.toml matches the branch name   |     **true**     |
|   `project-directory`    | **string**  |            The directory containing `Cargo.toml`             |      **.**       |
|         `shell`          | **string**  |                The shell used to run commands                |     **bash**     |

## Further references

- [check-rust-versions](../check-rust-versions/README.md)

- [install-wasm-pack](../install-wasm-pack/README.md)

- [check-artifact-version](../check-artifact-version/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [aurora-github](../../README.md)
