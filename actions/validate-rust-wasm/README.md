# validate-rust-wasm

Validates the source files of a Rust web assembly - which is especially useful as a condition for merging a pull request.

## Example

The action can be placed right after checking out the source code:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: giancosta86/aurora-github/actions/validate-rust-wasm
```

## How it works

1. Invoke the [install-wasm-pack](../install-wasm-pack/README.md) action, passing all the matching inputs, to install the `wasm-pack` command

1. Invoke the [validate-rust-crate](../validate-rust-crate/README.md) action, passing all the matching inputs, to perform code analysis over the Rust source code

1. Run `wasm-pack test` to run headless browser tests

1. If the `client-tests-directory` input parameter is not set to an empty string:

   1. Ensure the directory really exists

   1. Run `pnpm install` to install its dependencies

   1. Run `pnpm test` to run the NodeJS-based client tests

## Requirements

- `rust-toolchain.toml` must be present in `project-directory` - as described in [print-rust-info](../print-rust-info/README.md)

- if `client-tests-directory` is not set to an empty string, it must be the **relative path** of a directory containing:

  - a `.nvmrc` file, with the requested Node.js version

  - a `package.json` descriptor having:

    - a `test` script, in the `scripts` section

    - as usual, all the dependencies required by the test

  - an updated `pnpm-lock.yaml` lockfile

  It is worth mentioning that no quality checks - such as code formatting and linting - are performed on this test project.

## Inputs

|           Name           |    Type     |                            Description                             |  Default value   |
| :----------------------: | :---------: | :----------------------------------------------------------------: | :--------------: |
| `client-tests-directory` | **string**  |    Relative directory containing the NodeJS-based client tests     | **client-tests** |
| `check-artifact-version` | **boolean** | Runs [check-artifact-version](../check-artifact-version/README.md) |     **true**     |
|   `project-directory`    | **string**  |               The directory containing `Cargo.toml`                |      **.**       |
|         `shell`          | **string**  |                   The shell used to run commands                   |     **bash**     |

## Further references

- [install-wasm-pack](../install-wasm-pack/README.md)

- [validate-rust-crate](../validate-rust-crate/README.md)

- [print-rust-info](../print-rust-info/README.md)

- [aurora-github](../../README.md)
