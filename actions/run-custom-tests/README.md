# run-custom-tests

Executes arbitrary tests within a given directory; it runs a shell script by default, but can also run _pnpm_ (for **NodeJS**) or _cargo_ (for **Rust**).

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/aurora-github/actions/run-custom-tests@v11
    with:
      root-directory: client-tests
```

## 💡 How it works

1. If `root-directory` does not exist:

   1. If `optional` is **true**, exit the action successfully.

   1. Otherwise, crash the workflow.

1. Use `root-directory` as the current directory.

1. Select the first feasible course of action:

   1. If `script-file` is specified **and** can be run by forwarding it to [run-shell-script](../run-shell-script/README.md), invoke the action accordingly, passing the (optional) `script-shell`.

   1. If **verify** (**.elv**, **.sh**, ...) exists in `working-directory` **and** can be run via [run-shell-script](../run-shell-script/README.md), invoke the action accordingly, passing the (optional) `script-shell`.

   1. If one or more files having `.test.elv` extension exist in the root directory, run the tests within them, assuming the test format introduced by [aurora-elvish](https://github.com/giancosta86/aurora-elvish)

   1. If a file named **package.json** exists in the root directory:

      1. Invoke [setup-nodejs-context](../setup-nodejs-context/README.md).

      1. Run the **verify** script in the **scripts** section of **package.json**.

   1. If a file named **Cargo.toml** exists in the root directory:

      1. Invoke [setup-rust-context](../setup-rust-context/README.md), without enforcing the existence of the toolchain file.

      1. Run `cargo test`:

         1. with no features enabled

         1. with all the features enabled

   1. Otherwise:

      1. If `optional` is **true**, exit the action successfully.

      1. Otherwise, crash the workflow.

## 💬 Remarks

- You should **not** call this action for unit tests when using [verify-rust-crate](../verify-rust-crate/README.md) or [verify-npm-package](../verify-npm-package/README.md) - they are automatically run by the workflow itself.

- This action is already called by [verify-rust-wasm](../verify-rust-wasm/README.md) to optionally run the tests in the **client-tests** directory.

- This action is already called by [verify-npm-package](../verify-npm-package/README.md) to optionally run the tests in the **tests** directory.

## 📥 Inputs

|       Name       |    Type     |                 Description                  | Default value |
| :--------------: | :---------: | :------------------------------------------: | :-----------: |
|    `optional`    | **boolean** | Exit successfully if the tests cannot be run |   **false**   |
|  `script-file`   | **string**  |       Relative path to the script file       |               |
|  `script-shell`  | **string**  |     The shell used to run `script-file`      |               |
| `root-directory` | **string**  |      The directory containing the tests      |               |

## 🌐 Further references

- [run-shell-script](../run-shell-script/README.md)

- [setup-nodejs-context](../setup-nodejs-context/README.md)

- [setup-rust-context](../setup-rust-context/README.md)

- [verify-rust-crate](../verify-rust-crate/README.md)

- [verify-npm-package](../verify-npm-package/README.md)

- [verify-rust-wasm](../verify-rust-wasm/README.md)

- [aurora-elvish](https://github.com/giancosta86/aurora-elvish)

- [aurora-github](../../README.md)
