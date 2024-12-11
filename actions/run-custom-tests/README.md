# run-custom-tests

Executes arbitrary tests within a given directory; it runs a **shell** script by default, but can also run _pnpm_ (for **NodeJS**) or _cargo_ (for **Rust**).

## Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/run-custom-tests@v8
    with:
      root-directory: client-tests
```

### Remarks

- You should **not** call this action for unit tests when using [verify-rust-crate](../verify-rust-crate/README.md) or [verify-npm-package](../verify-npm-package/README.md) - they are automatically run by the workflow itself.

- This action is already called by [verify-rust-wasm](../verify-rust-wasm/README.md) to optionally run the tests in the **client-tests** directory.

- This action is already called by [verify-npm-package](../verify-npm-package/README.md) to optionally run the tests in the **tests** directory.

## How it works

1. If `root-directory` does not exist:

   - if `optional` is **true**, exit the action with no error

   - otherwise, crash the workflow

1. Detect the test type and act accordingly:

   - If a file named like `script-file` exists in the root directory, run it using `script-shell`; consequently, there is no need to mark the file as _executable_

   - Otherwise, if a file named **package.json** exists in the root directory:

     1. run [setup-nodejs-context](../setup-nodejs-context/README.md)

     1. run the **verify** script in the **scripts** section of **package.json**

   - Otherwise, if a file named **Cargo.toml** exists in the root directory:

     1. if the **rust-toolchain.toml** file exists, run [check-rust-versions](../check-rust-versions/README.md) to enforce a specific Rust toolkit

     1. run `cargo test` with the `--all-features` flag

   - Otherwise:

     - if `optional` is **true**, exit the action with no error

     - otherwise, crash the workflow

## Requirements

## Inputs 📥

|       Name       |    Type     |                  Description                  | Default value |
| :--------------: | :---------: | :-------------------------------------------: | :-----------: |
|    `optional`    | **boolean** | Exit with no error if the tests cannot be run |   **false**   |
|  `script-file`   | **string**  |       Relative path to the script file        | **verify.sh** |
|  `script-shell`  | **string**  |      The shell used to run `script-file`      |   **bash**    |
| `root-directory` | **string**  |      The directory containing the tests       |               |

## Further references

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [check-rust-versions](../check-rust-versions/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-github](../../README.md)
